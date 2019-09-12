//
//  NetworkManager.swift
//  NetworkLayer
//
//  Created by Sandeep Kumar on 21/11/18.
//  Copyright © 2018 Q3 Technologies. All rights reserved.
//

import Foundation
import RealmSwift

enum NetworkResponse:String {
    
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
    
}

enum ResultStatus<String>{
    case success
    case failure(String)
}

class NetworkManager {
    let router = Router.sharedInstance
 
    func processImage(image: String, completion: @escaping (_ data: ImagePatternResponse?,_ error: String?) -> ()){
        router.request(.processImagePattern(imageBase64: image)) { data, response, error in
            
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        print(responseData)
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        let apiResponse = try JSONDecoder().decode(ImagePatternResponse.self, from: responseData)
                        completion(apiResponse,nil)
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    
    func login(email: String, password: String, completion: @escaping (_ data: LoginDetails?,_ error: String?) -> ()) {
        router.request(.login(email: email, password: password)) { data, response, error in
            
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        print(responseData)
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        let apiResponse = try JSONDecoder().decode(LoginDetails.self, from: responseData)
                        completion(apiResponse,nil)
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
  
    func signUp(params: [String: Any], countryCode: String, completion: @escaping (_ data: LoginDetails?,_ error: String?) -> ()){
        router.request(.signUp(dict: params)) { data, response, error in
            
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        debugPrint(responseData)
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        debugPrint(jsonData)
                        let apiResponse = try JSONDecoder().decode(LoginDetails.self, from: responseData)
                        completion(apiResponse,nil)
                        return
                    }catch {
                        debugPrint(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                        return
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                    return
                }
            }
        }
    }
    
    func getVerificationCode(userId: String, completion: @escaping (_ code: Int64?, _ success: Bool,_ error: String?) -> ()){
        router.request(.verificationCode(userId: userId)) { data, response, error in
            
            if error != nil {
                completion(nil, false, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, false, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        
                        debugPrint(jsonData)
                        
                        let code = try JSONDecoder().decode(VerificationCode.self, from: responseData, keyedBy: "Data")

                        completion(code.mobileOTP, true, nil)
                        return
                    }catch {
                        debugPrint(error)
                        completion(nil, false, NetworkResponse.unableToDecode.rawValue)
                        return
                    }
                case .failure(let networkFailureError):
                    completion(nil, false, networkFailureError)
                    return
                }
            }
        }
    }
    
    func verifyCode(userId: String, OTP: String, completion: @escaping ( _ success: Bool,_ error: String?) -> ()){
        router.request(.verifyOTP(userId: userId, OTP: OTP)) { data, response, error in
            
            if error != nil {
                completion( false, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(false, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        
                        debugPrint(jsonData)
                        
                        let apiResponse = try JSONDecoder().decode(ResponseFormat.self, from: responseData)
                        
                        completion(true, apiResponse.message)
                        return
                    }catch {
                        debugPrint(error)
                        completion(false, NetworkResponse.unableToDecode.rawValue)
                        return
                    }
                case .failure(let networkFailureError):
                    completion( false, networkFailureError)
                    return
                }
            }
        }
    }
        
        func getCountryCode(completion: @escaping (_ code: [CountryCode]?, _ success: Bool,_ error: String?) -> ()){
            
//            self.serviceForEndPoint(apiType: .countryCode, decodingType: [CountryCode].self) { (result, apierror) in
//
//                result.
//
//                completion(nil, false, NetworkResponse.noData.rawValue)
//            }
            router.request(.countryCode) { data, response, error in

                if error != nil {
                    completion(nil, false, "Please check your network connection.")
                }

                if let response = response as? HTTPURLResponse {
                    let result = self.handleNetworkResponse(response)
                    switch result {
                    case .success:
                        guard let responseData = data else {
                            completion(nil, false, NetworkResponse.noData.rawValue)
                            return
                        }
                        do {
                            let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)

                            debugPrint(jsonData)

                            let codes = try JSONDecoder().decode([CountryCode].self, from: responseData, keyedBy: "Data")
                            //                        let realm = try! Realm()
                            //                        try? realm.write {
                            //                            let code = realm.objects(CountryCode.self)
                            //
                            //                            realm.delete(code)
                            //                        }
                            //
                            //                        for code in codes {
                            //                            try! realm.write {
                            //                                realm.add(code)
                            //                            }
                            //                        }
                            completion(codes, true, nil)
                            return
                        }catch {
                            debugPrint(error)
                            completion(nil, false, NetworkResponse.unableToDecode.rawValue)
                            return
                        }
                    case .failure(let networkFailureError):
                        completion(nil, false, networkFailureError)
                        return
                    }
                }
            }
    }
    
     func handleNetworkResponse(_ response: HTTPURLResponse) -> ResultStatus<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
}
