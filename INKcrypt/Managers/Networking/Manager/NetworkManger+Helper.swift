//
//  NetworkManger+Helper.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 3/11/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

//extension NetworkManager {
//
//    enum ResponseResult<APIError>{
//        case success
//        case failure(APIError)
//    }
//
//    enum Result<T,U> where U: Error {
//        case success(ResponseFormat?,T?)
//        case failure(U)
//    }
//
//    struct Response: Codable {
//        var message : String
//        var isSuccess : Bool
//    }
//
//    enum APIError: Error {
//        case requestFailed
//        case jsonConversionFailure
//        case invalidData
//        case responseUnsuccessful
//        case jsonParsingFailure
//        case noInternetConnection
//        case noData
//        case authenticationError
//        case badRequest
//        case outdated
//
//        var localizedDescription: String {
//            switch self {
//            case .requestFailed: return "Request Failed"
//            case .invalidData: return "Invalid Data"
//            case .responseUnsuccessful: return "Response Unsuccessful"
//            case .jsonParsingFailure: return "JSON Parsing Failure"
//            case .jsonConversionFailure: return "JSON Conversion Failure"
//            case .noInternetConnection: return "No Internet Connection"
//            case .noData: return "No Data"
//            case .authenticationError : return "Authentication Error"
//            case .badRequest : return "bad Request"
//            case .outdated : return "outdated"
//            }
//        }
//    }
//
//    func serviceForEndPoint<T : Decodable>(apiType : Api,decodingType : T.Type, completion: @escaping (Result<T, APIError>) -> Void) {
//        router.request(apiType) { (data, response, error) in
//
//            guard error == nil else {
//                completion(Result.failure(.responseUnsuccessful))
//                return
//            }
//
//            if let response = response as? HTTPURLResponse {
//                let result = self.handleResponse(response)
//                switch result {
//                case .success:
//                    guard let responseData = data else {
//                        completion(Result.failure(.noData))
//                        return
//                    }
//                    do {
//                        let JSON = try JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:Any]
//                        debugPrint("JSON:- \(String(describing: JSON))")
//                        let response = try JSONDecoder().decode(ResponseFormat.self, from: responseData)
//                        if let dict = JSON,self.isValidObject(dict["Data"] as AnyObject)  {
//                            let genericModel = try JSONDecoder().decode(decodingType, from: responseData, keyedBy :"Data")
//                            completion(Result.success(response,genericModel))
//                        } else {
//                            completion(Result.success(response,nil))
//                        }
//                    } catch {
//                        print(error.localizedDescription)
//                        completion(Result.failure(.jsonConversionFailure))
//                    }
//
//                case .failure(let error):
//                    completion(Result.failure(error))
//                }
//            }
//
//        }
//
//    }
//
//     func isValidObject(_ object: AnyObject?) -> Bool {
//        if object! is NSNull || object == nil {
//            return false
//        }
//        return true
//    }
//
//
//    fileprivate func handleResponse(_ response: HTTPURLResponse) -> ResponseResult<APIError> {
//        switch response.statusCode {
//        case 200...299: return .success
//        case 401...500: return .failure(.authenticationError)
//        case 501...599: return .failure(.badRequest)
//        case 600: return .failure(.outdated)
//        default: return .failure(.requestFailed)
//        }
//    }
//
//}
