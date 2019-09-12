//
//  NetworkService.swift
//  NetworkLayer
//
//  Created by Sandeep Kumar on 21/11/18.
//  Copyright © 2018 Q3 Technologies. All rights reserved.
//

import Foundation
import RealmSwift

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?) -> ()
typealias ApiRequest = (Api, NetworkRouterCompletion)

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}

class Router: NetworkRouter {
    static let sharedInstance = Router()
    private var task: URLSessionTask?
    private var apiList = [ApiRequest]()
    private var isTokenRefreshCalled = false
    private let urlSession : URLSession?
    
    private init(){
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        urlSession = URLSession.init(configuration: config)
    }
    
    
    func request(_ route: Api, completion: @escaping NetworkRouterCompletion) {
        
        if self.isTokenRefreshCalled {
            self.apiList.append((route, completion))
        }else {
            if let session = urlSession{
                do {
                    let request = try self.buildRequest(from: route)
                    NetworkLogger.log(request: request)
                    task = session.dataTask(with: request, completionHandler: { data, response, error in
                        
                        if let response = response as? HTTPURLResponse {
                            debugPrint("Response :- \(response)")
                            switch  response.statusCode {
                            case 401:
                                debugPrint("Token Refresh.......")
                                self.apiList.removeAll()
                                self.apiList.append((route, completion))
                                self.refreshTokenExpire()
                                
                            default:
                                completion(data, response, error)
                            }
                        }
                    })
                }catch {
                    completion(nil, nil, error)
                }
                self.task?.resume()
            }
        }
    }
    
    func cancel(  ) {
        self.task?.cancel()
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let bodyParameters,
                                    let bodyEncoding,
                                    let urlParameters):
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters,
                                              let bodyEncoding,
                                              let urlParameters,
                                              let additionalHeaders):
                
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         bodyEncoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    //MARK:- Refresh Token Handling
    func callApiList(){
        
        for api in self.apiList {
            self.request(api.0, completion: api.1)
        }
        self.apiList.removeAll()
    }
    
    func showSessionExpireAlert(){
        let alertController = UIAlertController(title: AlertMessages.alertTitle.localized, message: AlertMessages.sessionExpire.localized, preferredStyle: .alert)
        let okAction = UIAlertAction(title: AlertMessages.alertOk.localized, style: UIAlertAction.Style.default) {
            UIAlertAction in
            debugPrint("User logout")
            self.isTokenRefreshCalled = false
            self.sessionExpireAction()
        }
        alertController.addAction(okAction)
        DispatchQueue.main.async {
            if let viewC = UIApplication.topViewController() {
                (viewC as? ViewController)?.loadingViewController.remove()
                viewC.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func sessionExpireAction(){
        if let user = LoginDetails.getUser() {
            //add(loadingViewController)
            DispatchQueue.main.async {
                if let viewC = UIApplication.topViewController(), let loadVC = (viewC as? ViewController)?.loadingViewController {
                    viewC.add(loadVC)
                }
            }
            let dict = [Constants.APIParameterKey.UserId:user.userID,Constants.APIParameterKey.uniqueDeviceID : UIDevice.current.identifierForVendor!.uuidString] as [String : Any]
            self.serviceForEndPoint(apiType: .logout(model: dict), decodingType: Profile.self) {[weak self] (result) in
                DispatchQueue.main.async {
                    if let viewC = UIApplication.topViewController() {
                        (viewC as? ViewController)?.loadingViewController.remove()
                    }
                    switch result {
                    case .success( _, _):
                        self?.clearRealmDataBase()
                    case .failure(let error):
                        debugPrint(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func clearRealmDataBase() {
        guard let realm = try? Realm() else { return }
        try? realm.write {
            realm.deleteAll()
        }
    }
    
    func refreshTokenExpire(){
        
        self.isTokenRefreshCalled = true
        self.refreshTokenRequestAPICall(completion: { (data, response, error) in

            
            guard error == nil else {
                debugPrint("/n /n error :-",error as Any)
                self.showSessionExpireAlert()
                return
            }
            
            if let response = response as? HTTPURLResponse {
                
                let result = self.handleResponse(response)
                
                switch result {
                    
                case .success:
                    guard let responseData = data else {
                        debugPrint("Token request data nil........")
                        
                        return
                    }
                    do {
                        let JSON = try JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:Any]
                        debugPrint("/n /n JSON :-",JSON ?? "")
                        let response = try JSONDecoder().decode(ResponseFormat.self, from: responseData)
                        debugPrint("/n /n Response :-",response)
                        if let dict = JSON,self.isValidObject(dict["Data"] as AnyObject){
                            let genericModel = try JSONDecoder().decode(RefreshToken.self, from: responseData, keyedBy :"Data")
                            
                            debugPrint("/n /n Model:-",genericModel)
                            self.updateUserModel(genericModel: genericModel)
                            
                            self.isTokenRefreshCalled = false
                            self.callApiList()
                        }else{
                            self.showSessionExpireAlert()
                            return
                        }
                    } catch {
                        debugPrint(error)
                    }
                    
                case .failure(let error):
                    debugPrint("Token request Failure:- \(error.localizedDescription)")
                    self.showSessionExpireAlert()
                    return
                }
            }
        })
    }
    
    func updateUserModel(genericModel : RefreshToken) {
        guard let realm = try? Realm() else { return }
        let users = realm.objects(LoginDetails.self)
        if let user = users.first {
            do {
                try realm.write {
                    user.accessToken?.authToken = genericModel.accessToken?.authToken
                    user.refreshToken = genericModel.refreshToken
                    realm.add(user, update: true)
                }
                
            } catch {
                debugPrint(error)
            }
        }
    }
    
    
    func refreshTokenRequestAPICall( completion: @escaping NetworkRouterCompletion) {
        
        if let user = LoginDetails.getUser(), let authToken = user.accessToken?.authToken, let refreshToken = user.refreshToken {
            
            let route = Api.refreshToken(authToken: authToken , refreshToken: refreshToken)
            
            debugPrint("Refresh Token Api:- \(route)")
            
            if let session = self.urlSession {
                do {
                    let request = try self.buildRequest(from: route)
                    NetworkLogger.log(request: request)
                    task = session.dataTask(with: request, completionHandler: { data, response, error in
                        completion(data, response, error)
                    })
                }catch {
                    completion(nil, nil, error)
                }
                self.task?.resume()
            }
        }
    }
    
}

