//
//  LoginResponse.swift
//  INKcrypt
//
//  Created by Sandeep Kumar on 04/03/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

struct ResponseFormat : Decodable {
    
    var success: Bool = false
    var code: Int64?
    var message: String?
    var totalPage: Int64?
    var currentPage: Int64?
    
    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case code = "Code"
        case message = "Message"
        case totalPage = "TotalPage"
        case currentPage = "CurrentPage"
    }
}


class RefreshToken: Codable {
    let accessToken: AccessToken1?
    let refreshToken: String?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "accessToken"
        case refreshToken = "RefreshToken"
    }
    
    init(accessToken: AccessToken1?, refreshToken: String?) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}

class AccessToken1: Codable {
    let authToken: String?
    
    enum CodingKeys: String, CodingKey {
        case authToken = "AuthToken"
    }
    
    init(authToken: String?) {
        self.authToken = authToken
    }
}


class AccessToken : Object, Decodable {
     @objc dynamic var identifier = 1
     @objc dynamic var authToken: String?
     @objc dynamic var expiresIn: Int64 = 0
    
    enum CodingKeys: String, CodingKey {
        case authToken = "AuthToken"
        case expiresIn = "ExpiresIn"
    }
    
    public required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let expiresIn = try container.decodeIfPresent(Int64.self, forKey: .expiresIn)
        let authToken = try container.decodeIfPresent(String.self, forKey: .authToken)
        self.init(expiresIn: expiresIn, authToken: authToken)
    }
    
    convenience init(expiresIn: Int64?, authToken: String?) {
        self.init()
        self.expiresIn = expiresIn ?? 0
        self.authToken = authToken
    }
    
    override static func primaryKey() -> String? {
        return "identifier"
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}

class LoginDetails: Object, Decodable {

    @objc dynamic var userID: Int64 = -1
    @objc dynamic var userName: String?
    //@objc dynamic var authToken: String?
    @objc dynamic var email: String?
    @objc dynamic var roleID: Int64 = 0
    @objc dynamic var roleName: String?
    @objc dynamic var otp: Int64 = 0
    @objc dynamic var otpVerification: Bool = false
    @objc dynamic var uniqueDeviceID: String?
    
    @objc dynamic var address1: String?
    @objc dynamic var address2: String?
    @objc dynamic var areaCode: String?
    
    @objc dynamic var companyCityName: String?
    @objc dynamic var companyCountryCode: String?
    @objc dynamic var companyName: String?
    @objc dynamic var companyPhoneNo: String?
    @objc dynamic var companyZipcode: String?
    @objc dynamic var companycountryName: String?
    @objc dynamic var companystateName: String?
    
    @objc dynamic var userCountryCode: String?
    @objc dynamic var userMobileNo: String?
    @objc dynamic var accessToken: AccessToken?
    @objc dynamic var refreshToken: String?
    @objc dynamic var isStarterKit: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case userID = "UserID"
        case userName = "UserName"
        case authToken = "AuthToken"
        case email = "Email"
        case roleID = "RoleID"
        case roleName = "RoleName"
        case otp = "OTP"
        case otpVerification = "OTPVerification"
        case uniqueDeviceID = "UniqueDeviceID"
        
        case address1 = "Address1"
        case address2 = "Address2"
        case areaCode = "AreaCode"
        
        case companyCityName = "CompanyCityName"
        case companyCountryCode = "CompanyCountryCode"
        case companyName = "CompanyName"
        case companyPhoneNo = "CompanyPhoneNo"
        case companyZipcode = "CompanyZipcode"
        case companycountryName = "CompanycountryName"
        case companystateName = "CompanystateName"
        
        case userCountryCode = "UserCountryCode"
        case userMobileNo = "UserMobileNo"
        case accessToken = "accessToken"
        case refreshToken = "RefreshToken"
        case isStarterKit = "IsStarterKit"
    }
    
    
    
    public required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let userID = try container.decodeIfPresent(Int64.self, forKey: .userID)
        let userName = try container.decodeIfPresent(String.self, forKey: .userName)
        let authToken = try container.decodeIfPresent(String.self, forKey: .authToken)
        let email = try container.decodeIfPresent(String.self, forKey: .email)
        let roleID = try container.decodeIfPresent(Int64.self, forKey: .roleID)
        let roleName = try container.decodeIfPresent(String.self, forKey: .roleName)
        let otp = try container.decodeIfPresent(Int64.self, forKey: .otp)
        let otpVerification = try container.decodeIfPresent(Bool.self, forKey: .otpVerification)
        let uniqueDeviceID = try container.decodeIfPresent(String.self, forKey: .uniqueDeviceID)
        
        let address1 = try container.decodeIfPresent(String.self, forKey: .address1)
        let address2 = try container.decodeIfPresent(String.self, forKey: .address2)
        let areaCode = try container.decodeIfPresent(String.self, forKey: .areaCode)
        
        let companyCityName = try container.decodeIfPresent(String.self, forKey: .companyCityName)
        let companyCountryCode = try container.decodeIfPresent(String.self, forKey: .companyCountryCode)
        let companyName = try container.decodeIfPresent(String.self, forKey: .companyName)
        let companyPhoneNo = try container.decodeIfPresent(String.self, forKey: .companyPhoneNo)
        let companyZipcode = try container.decodeIfPresent(String.self, forKey: .companyZipcode)
        let companycountryName = try container.decodeIfPresent(String.self, forKey: .companycountryName)
        let companystateName = try container.decodeIfPresent(String.self, forKey: .companystateName)
        
        let userCountryCode = try container.decodeIfPresent(String.self, forKey: .userCountryCode)
        let userMobileNo = try container.decodeIfPresent(String.self, forKey: .userMobileNo)
        let accessToken = try container.decodeIfPresent(AccessToken.self, forKey: .accessToken)
        let refreshToken = try container.decodeIfPresent(String.self, forKey: .refreshToken)
        let isStarterKit = try container.decodeIfPresent(Bool.self, forKey: .isStarterKit)

        
        self.init(userID: userID!, userName: userName, email: email, roleID: roleID!, roleName: roleName, otp: otp!, otpVerification: otpVerification!, uniqueDeviceID: uniqueDeviceID, address1: address1, address2: address2, areaCode: areaCode, companyCityName: companyCityName, companyCountryCode: companyCountryCode, companyName: companyName, companyPhoneNo: companyPhoneNo, companyZipcode: companyZipcode, companycountryName: companycountryName, companystateName: companystateName, userCountryCode: userCountryCode, userMobileNo: userMobileNo, accessToken : accessToken,refreshToken: refreshToken, isStarterKit: isStarterKit!)
        
    }
    
    convenience init(userID: Int64, userName: String?, email: String?, roleID: Int64, roleName: String?, otp: Int64, otpVerification: Bool, uniqueDeviceID: String?, address1: String?, address2: String?, areaCode: String?, companyCityName: String?, companyCountryCode: String?, companyName: String?, companyPhoneNo: String?, companyZipcode: String?,
                     companycountryName: String?, companystateName: String?, userCountryCode: String?, userMobileNo: String?, accessToken : AccessToken?, refreshToken: String?, isStarterKit: Bool) {
        
        self.init()
        self.userID = userID
        self.userName = userName
        //self.authToken = authToken
        self.email = email
        self.roleID = roleID
        self.roleName = roleName
        self.otp = otp
        self.otpVerification = otpVerification
        self.uniqueDeviceID = uniqueDeviceID
        
        self.address2 = address2
        self.areaCode = areaCode
        
        self.companyCityName = companyCityName
        self.companyCountryCode = companyCountryCode
        self.companyName = companyName
        self.companyPhoneNo = companyPhoneNo
        self.companyZipcode = companyZipcode
        self.companycountryName = companycountryName
        self.companystateName = companystateName
        
        self.userCountryCode = userCountryCode
        self.userMobileNo = userMobileNo
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.isStarterKit = isStarterKit
    }
    
    override static func primaryKey() -> String? {
        return "userID"
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    class func getUser() -> LoginDetails? {
        guard let realm = try? Realm() else { return nil }
        let users = realm.objects(LoginDetails.self)
        if users.count > 0 {
            return users.first
        }
        return nil
    }
    
    class func authenticationHeader() -> [String:String] {
        if let user = LoginDetails.getUser() {
            let header : [String:String] =  ["ApiVersion":"1.0","AppVersion":"1.0","DeviceType":Constants.DeviceType.deviceTypeId,"accessToken":user.accessToken?.authToken ?? "","secretKey":"wTKYlq6eNueNdc6WbgA8op27Yulhe6uh"]
            return header
        } else {
         return ["ApiVersion":"1.0","AppVersion":"1.0","DeviceType":Constants.DeviceType.deviceTypeId,"secretKey":"wTKYlq6eNueNdc6WbgA8op27Yulhe6uh"]
        }
    }
    
}

