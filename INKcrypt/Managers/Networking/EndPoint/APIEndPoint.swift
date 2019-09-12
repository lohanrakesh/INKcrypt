//
//  APIEndPoint.swift
//  NetworkLayer
//
//  Created by Sandeep Kumar on 21/11/18.
//  Copyright © 2018 Q3 Technologies. All rights reserved.
//

import Foundation

enum Api {
    case addToCart(model : [String:Any])
    case removeFromCart(model : [String:Any])
    case getOrderHistoryDetails(model : [String:Any])
    case getOrderHistoryByOrderID(model : [String:Any])
    case logout(model : [String:Any])
    case getCountryList(model : [String:Any])
    case getStateList(countryID:Int)
    case getUserAppSetting(model : [String:Any])
    case saveUserAppSetting(model : [String:Any])
    case saveAddress(model : [String:Any])
    case getAddressList(model : [String:Any])
    case removeAddressList(model : [String:Any])
    case sampleData(identifier:Int)
    case processImagePattern(imageBase64:String)
    case login(email:String, password:String)
    case signUp(dict: [String: Any])
    case countryCode
    case verificationCode(userId:String)
    case verifyOTP(userId:String, OTP:String)
    case profile(model : [String:Any])
    case updateProfile(model : [String:Any])
    case forgotPassword(email: String)
    case changePassword(model : [String:Any])
    case contactUs(name: String, email: String, company: String, phoneNumber: String, description: String, userId: String)
    case aboutUs
    case termCondition
    case refreshToken(authToken: String, refreshToken: String)
    case productList(pageIndex: Int64, pageSize: Int64)
    case getCart(cartId: Int?, userId: Int64?)
    case getDeliveryType
    case home(model : [String:Any])
    case deviceToken(dict: [String: Any])
}

extension Api: EndPointType {
    
    var environmentBaseURL : String {
        return ConfigurationManager.sharedManager().applicationEndPoint()
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .getOrderHistoryDetails( _):
            return "Order/GetOrderHistoryDetails"
        case .getOrderHistoryByOrderID( _):
            return "Order/GetOrderHistoryByOrderID"
        case .addToCart( _):
            return "Cart/AddToCart"
        case .removeFromCart( _):
            return "Cart/RemoveFromCart"
        case .logout:
            return "/Account/LogOut"
        case .getCountryList:
            return "/General/GetCountry"
        case .getStateList( _):
            //return "General/GetStateMaster?CountryID=\(countryID)"
            return "General/GetStateMaster"
        case .getUserAppSetting:
            return "User/GetUserAppSetting"
        case .saveUserAppSetting:
            return "User/SaveUserAppSetting"
        case .saveAddress:
            return "Address/SaveAddress"
        case .getAddressList:
            return "Address/GetAddressList"
        case .removeAddressList:
            return "Address/RemoveAddress"
        case .sampleData( _):
            return ""
        case .processImagePattern:
            return "/General/GetDataFromScript"
        case .login:
            return "/Account/ValidateSignIn"
        case .signUp:
            return "/Account/UserRegistration"
        case  .countryCode:
            return "/General/GetCountryMasterCode"
        case .verificationCode:
            return "/OTP/GetOTPDetails"
        case .verifyOTP:
            return "/OTP/VerifyOTP"
        case .profile:
            return "/User/GetUserProfile"
        case .updateProfile:
            return "User/SaveUserProfile"
        case .forgotPassword:
            return "/Account/ForgotPassword"
        case .changePassword:
            return "/User/ChangePassword"
        case .contactUs:
            return "/Anonymous/SaveContactSupport"
        case .aboutUs:
            return "/Anonymous/AboutInkCrypt"
        case .termCondition:
            return "/Anonymous/TermsAndConditions"
        case .refreshToken:
            return "/Account/RefreshToken"
        case .productList:
            return "/Product/GetProductList"
        case .getCart:
            return "/Cart/GetCartListForUser"
        case .getDeliveryType:
            return "/Order/GetDeliveryType"
        case .home:
            return "/Product/GetProductForHome"
        case .deviceToken:
            return "/Notification/UpdateNotificationSenderKey"
       
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .sampleData, .countryCode,.getStateList,.getCountryList :
            return .get
        case .processImagePattern,.getUserAppSetting,.saveUserAppSetting,.getAddressList,.saveAddress,.removeAddressList,.login, .signUp, .verificationCode, .verifyOTP,.profile,.updateProfile, .forgotPassword,.changePassword, .contactUs, .aboutUs, .termCondition, .logout, .refreshToken, .productList,.addToCart,.removeFromCart, .getCart, .getDeliveryType,.getOrderHistoryDetails,.getOrderHistoryByOrderID, .home , .deviceToken:
            return .post
       
        }
    }
    
    var task: HTTPTask {
        switch self {
            
        case .saveUserAppSetting(let dict), .getAddressList(let dict),.saveAddress(let dict),.getUserAppSetting(let dict),.removeAddressList(let dict),.updateProfile(let dict),.changePassword(let dict),.profile(let dict),.logout(let dict),.removeFromCart(let dict),.addToCart(let dict),.getOrderHistoryDetails(let dict),.getOrderHistoryByOrderID(let dict), .home(let dict), .deviceToken(let dict):
            return .requestParametersAndHeaders(bodyParameters: dict, bodyEncoding: .jsonEncoding, urlParameters: nil, additionHeaders : LoginDetails.authenticationHeader())
            
        case .getStateList(let countryID):
            return .requestParametersAndHeaders(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["CountryID":countryID], additionHeaders : LoginDetails.authenticationHeader())
            
        case .getCountryList( _), .countryCode, .getDeliveryType:
            return .requestParametersAndHeaders(bodyParameters: nil,
                                      bodyEncoding: .jsonEncoding,
                                      urlParameters: [:], additionHeaders : LoginDetails.authenticationHeader())
            
        case .sampleData( _):
            return .requestParametersAndHeaders(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: nil, additionHeaders : LoginDetails.authenticationHeader())
            
        case .processImagePattern(let image):
            return .requestParametersAndHeaders(bodyParameters: ["image":image],
                                      bodyEncoding: .jsonEncoding,
                                      urlParameters: nil, additionHeaders : LoginDetails.authenticationHeader())
            
        case .login(let email, let password):
            return .requestParametersAndHeaders(bodyParameters: ["UserName":email,"Password":password,"UniqueDeviceID":  UIDevice.current.identifierForVendor!.uuidString],
                                      bodyEncoding: .jsonEncoding,
                                      urlParameters: nil, additionHeaders : LoginDetails.authenticationHeader())
            
        case .signUp(let dict):
            return .requestParametersAndHeaders(bodyParameters: dict, bodyEncoding: .jsonEncoding,
                                      urlParameters: nil, additionHeaders : LoginDetails.authenticationHeader())
            
        case .verificationCode(let userId) :
            return .requestParametersAndHeaders(bodyParameters: ["UserID": userId, "UniqueDeviceID": UIDevice.current.identifierForVendor!.uuidString], bodyEncoding: .jsonEncoding, urlParameters: nil, additionHeaders : LoginDetails.authenticationHeader())
            
        case .verifyOTP(let userId, let OTP):
            return .requestParametersAndHeaders(bodyParameters: ["UserID": userId, "MobileOTP": OTP, "UniqueDeviceID": UIDevice.current.identifierForVendor!.uuidString], bodyEncoding: .jsonEncoding, urlParameters: nil, additionHeaders : LoginDetails.authenticationHeader())
            
            
        case .forgotPassword(let email):
            return .requestParametersAndHeaders(bodyParameters: ["UserName": email], bodyEncoding: .jsonEncoding, urlParameters: nil, additionHeaders : LoginDetails.authenticationHeader())
            
            
        case .contactUs(let name, let email, let company, let phoneNumber, let description, let userId):
            return .requestParametersAndHeaders(bodyParameters: ["Name": name, "Company": company, "EMail":email, "Phone": phoneNumber, "Description": description, "UserID": userId], bodyEncoding: .jsonEncoding, urlParameters: nil, additionHeaders : LoginDetails.authenticationHeader())
            
        case .aboutUs:
            return .requestParametersAndHeaders(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: nil, additionHeaders : LoginDetails.authenticationHeader())
        case .termCondition:
            return .requestParametersAndHeaders(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: nil, additionHeaders : LoginDetails.authenticationHeader())
            
        case .refreshToken(let authToken, let refreshToken):
            
            return .requestParametersAndHeaders(bodyParameters: ["accessToken": ["AuthToken": authToken], "RefreshToken": refreshToken], bodyEncoding: .jsonEncoding, urlParameters: nil, additionHeaders : LoginDetails.authenticationHeader())
            
        case .productList(let pageIndex, let pageSize):
            return .requestParametersAndHeaders(bodyParameters: ["PageIndex": pageIndex,"PageSize": pageSize], bodyEncoding: .jsonEncoding,  urlParameters: nil, additionHeaders : LoginDetails.authenticationHeader())
            
        case .getCart(let cartId, let userId):
            return .requestParametersAndHeaders(bodyParameters: ["CartID": cartId, "Userid" : userId], bodyEncoding: .jsonEncoding,  urlParameters: nil, additionHeaders : LoginDetails.authenticationHeader())
            
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return ["Content-Type":"application/json"]
    }
}



