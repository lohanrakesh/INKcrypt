//
//  AddressInfoModel.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 3/19/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

public struct Country: Codable {
    var text: String?
    var value : String?
    
    enum CodingKeys: String, CodingKey {
        case text = "Text"
        case value = "Value"
    }
}

public struct AddressInfoModel: Codable {
    let addressID: Int
    let shipAddress1, shipAddress2: String
    let countryID, stateID: Int
    let cityName, zipcode: String
    let isDefault: Bool
    let userID: Int
    let stateName, countryName, countryCode, fisrtName: String
    let lastName, eMail: String
    let isActive: Bool
    let createdBy: Int
    let createdDate: String
    
    
    enum CodingKeys: String, CodingKey {
        case addressID = "AddressId"
        case shipAddress1 = "ShipAddress1"
        case shipAddress2 = "ShipAddress2"
        case countryID = "CountryId"
        case stateID = "StateId"
        case cityName = "CityName"
        case zipcode = "Zipcode"
        case isDefault = "IsDefault"
        case userID = "UserId"
        case stateName, countryName
        case countryCode = "CountryCode"
        case fisrtName = "FisrtName"
        case lastName = "LastName"
        case eMail = "EMail"
        case isActive = "IsActive"
        case createdBy = "CreatedBy"
        case createdDate = "CreatedDate"
    }
}

public enum AddressMode {
    case add
    case edit
    case delete
}

public enum AddressType: String {
    case defaultAddress = "default"
    case otherAddress = "other"
}




