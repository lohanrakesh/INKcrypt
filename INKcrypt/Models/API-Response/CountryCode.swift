//
//  CountryCode.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 08/03/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class VerificationCode: Decodable {
    
   var mobileOTP: Int64?
    
    enum CodingKeys: String, CodingKey {
        case mobileOTP = "MobileOTP"
    }
    
    init(mobileOTP: Int64) {
        self.mobileOTP = mobileOTP
    }
}

class ForgotPassword: Decodable {
    
    var message: String?
    
    enum CodingKeys: String, CodingKey {
        case message = "Message"
    }
    
    init(message: String) {
        self.message = message
    }
}

class CountryCode: Object, Decodable {
    
    
    @objc dynamic var text: String?
    @objc dynamic var value: String?
    
    enum CountryCodeKeys: String, CodingKey {
        case text = "Text"
        case value = "Value"
    }
    
    public required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CountryCodeKeys.self)
        let text = try container.decodeIfPresent(String.self, forKey: .text)
        let value = try container.decodeIfPresent(String.self, forKey: .value)
        
        self.init(text: text, value: value)
        
    }
    
    convenience init(text: String?, value: String?) {
        self.init()
        self.text = text
        self.value = value
    }
    
    override static func primaryKey() -> String? {
        return "value"
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

