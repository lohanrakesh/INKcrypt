//
//  RouterExtension.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 29/04/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

extension Router {
    
    enum ResponseResult<APIError>{
        case success
        case failure(APIError)
    }
    
    enum Result<T,U> where U: Error {
        case success(ResponseFormat?,T?)
        case failure(U)
    }
    
    struct Response: Codable {
        var message : String
        var isSuccess : Bool
    }
    
    enum APIError: Error {
        case requestFailed
        case jsonConversionFailure
        case invalidData
        case responseUnsuccessful
        case jsonParsingFailure
        case noInternetConnection
        case noData
        case authenticationError
        case badRequest
        case outdated
        
        var localizedDescription: String {
            switch self {
            case .requestFailed: return "Network request failed."
            case .invalidData: return "Invalid Data"
            case .responseUnsuccessful: return "Response Unsuccessful"
            case .jsonParsingFailure: return "We could not decode the response."
            case .jsonConversionFailure: return "We could not decode the response."
            case .noInternetConnection: return "No Internet Connection"
            case .noData: return "Response returned with no data to decode."
            case .authenticationError : return "You need to be authenticated first."
            case .badRequest : return "Bad request"
            case .outdated : return "The url you requested is outdated."
            }
        }
    }
    
    func isValidObject(_ object: AnyObject?) -> Bool {
        if object! is NSNull || object == nil {
            return false
        }
        return true
    }
    
    
    func handleResponse(_ response: HTTPURLResponse) -> ResponseResult<APIError> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(.authenticationError)
        case 501...599: return .failure(.badRequest)
        case 600: return .failure(.outdated)
        default: return .failure(.requestFailed)
        }
    }
    
    //MARK:- API Call Method
    func serviceForEndPoint<T : Decodable>(apiType : EndPoint, decodingType : T.Type?, completion: @escaping (Result<T, APIError>) -> Void) {
        
        self.request(apiType) { (data, response, error) in
            
            guard error == nil else {
                debugPrint("/n /n error :-",error as Any)
                completion(Result.failure(.requestFailed))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                
                let result = self.handleResponse(response)
                
                switch result {
                    
                case .success:
                    guard let responseData = data else {
                        completion(Result.failure(.noData))
                        return
                    }
                    do {
                        let JSON = try JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:Any]
                        debugPrint("/n /n JSON :-",JSON ?? "")
                        let response = try JSONDecoder().decode(ResponseFormat.self, from: responseData)
                        debugPrint("/n /n Response :-",response)
                        if let dict = JSON,self.isValidObject(dict["Data"] as AnyObject),let codingType = decodingType  {
                            let genericModel = try JSONDecoder().decode(codingType, from: responseData, keyedBy :"Data")
                            debugPrint("/n /n Model:-",genericModel)
                            completion(Result.success(response,genericModel))
                        } else {
                            completion(Result.success(response,nil))
                        }
                    } catch {
                        debugPrint(error)
                        completion(Result.failure(.jsonConversionFailure))
                    }
                    
                case .failure(let error):
                    completion(Result.failure(error))
                }
            }
        }
    }
    
    
    func serviceForEndPointVersionTwo<T : Decodable>(apiType : EndPoint, decodingType : T.Type?, completion: @escaping (Result<T, APIError>) -> Void) {
        self.request(apiType) { (data, response, error) in
            
            guard error == nil else {
                debugPrint("/n /n error :-",error as Any)
                completion(Result.failure(.requestFailed))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(Result.failure(.noData))
                        return
                    }
                    do {
                        let JSON = try JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:Any]
                        
                        let response = try JSONDecoder().decode(ResponseFormat.self, from: responseData)
                        debugPrint("/n /n Response :-",response)
                        if let dict = JSON,self.isValidObject(dict["Data"] as AnyObject),let codingType = decodingType  {
                            let genericModel = try JSONDecoder().decode(codingType, from: responseData)
                            debugPrint("/n /n Model:-",genericModel)
                            completion(Result.success(response,genericModel))
                        } else {
                            completion(Result.success(response,nil))
                        }
                    } catch {
                        print(error)
                        completion(Result.failure(.jsonConversionFailure))
                    }
                    
                case .failure(let error):
                    completion(Result.failure(error))
                }
            }
        }
        
    }
    
}
