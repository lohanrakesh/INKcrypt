//
//  Profile.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 3/13/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

struct Profile: Codable {
    var companyInfoID,countryID,userID: Int?
    var companyName, companyCountryCode, areaCode, companyPhoneNo: String?
    var address1, address2: String?
    var stateID: String? 
    var companyCityName, companyZipcode, companystateName, companycountryName: String?
    var fisrtName, lastName, eMail, userMobileNo: String?
    var userCountryCode: String?
    var isActive: Bool?
    
    enum CodingKeys: String, CodingKey {
        case companyInfoID = "CompanyInfoId"
        case userID = "UserId"
        case companyName = "CompanyName"
        case companyCountryCode = "CompanyCountryCode"
        case areaCode = "AreaCode"
        case companyPhoneNo = "CompanyPhoneNo"
        case address1 = "Address1"
        case address2 = "Address2"
        case countryID = "CountryId"
        case stateID = "StateId"
        case companyCityName = "CompanyCityName"
        case companyZipcode = "CompanyZipcode"
        case companystateName = "CompanystateName"
        case companycountryName = "CompanycountryName"
        case fisrtName = "FisrtName"
        case lastName = "LastName"
        case eMail = "EMail"
        case userMobileNo = "UserMobileNo"
        case userCountryCode = "UserCountryCode"
        case isActive = "IsActive"
    }
}


struct UserSettingModel: Codable {
    let settingsID, userID: Int?
    let webURL, landingURL, testKitURL, imageBase64: String?
    let ntfcAll, ntfcPassOnly, ntfcFailOnly, ntfcNone: Bool?
    let fisrtName, lastName: String?
    let isActive: Bool?
    let createdBy: Int?
    let modifiedBy: Int?
    let createdDate: String?
    let modifiedDate: Int?
    
    enum CodingKeys: String, CodingKey {
        case settingsID = "SettingsId"
        case userID = "UserID"
        case webURL = "WebURL"
        case landingURL = "LandingURL"
        case testKitURL = "TestKitURL"
        case imageBase64 = "ImageBase64"
        case ntfcAll = "NTFCAll"
        case ntfcPassOnly = "NTFCPassOnly"
        case ntfcFailOnly = "NTFCFailOnly"
        case ntfcNone = "NTFCNone"
        case fisrtName = "FisrtName"
        case lastName = "LastName"
        case isActive = "IsActive"
        case createdBy = "CreatedBy"
        case modifiedBy = "ModifiedBy"
        case createdDate = "CreatedDate"
        case modifiedDate = "ModifiedDate"
    }
}

struct OrderList: Codable {
    let orderID, userID, paymentID, shipperID: Int?
    let shippingAddressID, billingAddressID, deliveryTypeID, promoCodeID: Int?
    let orderNumber, orderDate: String?
    let tax, shippingCharges: Int?
    let totalPrice: Double?
    let isActive: Bool?
    let createdDate: String?
    let promoDiscount: Int?
    let fisrtName, lastName, eMail: String?
    let mobileNo: String?
    let shippingAddress1, shippingAddress2, shippingCity, shippingZipCode: String?
    let shippingCountry, shippingState, shippingCountryCode, billingAddress1: String?
    let billingAddress2, billingCity, billingZipCode, billingCountry: String?
    let billingState, billingCountryCode: String?
    let shipperName, shipperPhone, shipperAddress: String?
    let paymentType, paymentDetails, promoCode, deliveryType: String?
    let deliveryCharges: Int?
    let subTotalPrice: Double?
    let orderHistoryListData: [OrderHistoryListDatum]
    
    enum CodingKeys: String, CodingKey {
        case orderID = "OrderID"
        case userID = "UserId"
        case paymentID = "PaymentID"
        case shipperID = "ShipperID"
        case shippingAddressID = "ShippingAddressID"
        case billingAddressID = "BillingAddressID"
        case deliveryTypeID = "DeliveryTypeID"
        case promoCodeID = "PromoCodeID"
        case orderNumber = "OrderNumber"
        case orderDate = "OrderDate"
        case tax = "Tax"
        case shippingCharges = "ShippingCharges"
        case totalPrice = "TotalPrice"
        case isActive = "IsActive"
        case createdDate = "CreatedDate"
        case promoDiscount = "PromoDiscount"
        case fisrtName = "FisrtName"
        case lastName = "LastName"
        case eMail = "EMail"
        case mobileNo = "MobileNo"
        case shippingAddress1 = "ShippingAddress1"
        case shippingAddress2 = "ShippingAddress2"
        case shippingCity = "ShippingCity"
        case shippingZipCode = "ShippingZipCode"
        case shippingCountry = "ShippingCountry"
        case shippingState = "ShippingState"
        case shippingCountryCode = "ShippingCountryCode"
        case billingAddress1 = "BillingAddress1"
        case billingAddress2 = "BillingAddress2"
        case billingCity = "BillingCity"
        case billingZipCode = "BillingZipCode"
        case billingCountry = "BillingCountry"
        case billingState = "BillingState"
        case billingCountryCode = "BillingCountryCode"
        case shipperName = "ShipperName"
        case shipperPhone = "ShipperPhone"
        case shipperAddress = "ShipperAddress"
        case paymentType = "PaymentType"
        case paymentDetails = "PaymentDetails"
        case promoCode = "PromoCode"
        case deliveryType = "DeliveryType"
        case deliveryCharges = "DeliveryCharges"
        case subTotalPrice = "SubTotalPrice"
        case orderHistoryListData
    }
}

struct OrderHistoryListDatum: Codable {
    let orderDetailID, productID: Int
    let detailOrderNumber: String
    let orderedquantity: Int
    let unitPrice: Double
    let discount, bioMarkerID: Int
    let smartQRCode: String
    let productPrice: Double
    let productName, productDescription: String
    let imagePath: String
    let levelName, customerLevelDescription: String
    
    enum CodingKeys: String, CodingKey {
        case orderDetailID = "OrderDetailID"
        case productID = "ProductID"
        case detailOrderNumber = "DetailOrderNumber"
        case orderedquantity = "Orderedquantity"
        case unitPrice = "UnitPrice"
        case discount = "Discount"
        case bioMarkerID = "BioMarkerID"
        case smartQRCode = "SmartQRCode"
        case productPrice = "ProductPrice"
        case productName = "ProductName"
        case productDescription = "ProductDescription"
        case imagePath = "ImagePath"
        case levelName = "LevelName"
        case customerLevelDescription = "CustomerLevelDescription"
    }
}

struct OrderDetail {
    let orderID, userID, paymentID, shipperID: Int?
    let shippingAddressID, billingAddressID, deliveryTypeID, promoCodeID: Int?
    let orderNumber, orderDate: String?
    let tax, shippingCharges: Int?
    let totalPrice: Double?
    let isActive: Bool?
    let createdBy: NSNull?
    let createdDate: String?
    let modifiedBy, modifiedDate: NSNull?
    let promoDiscount: Int?
    let fisrtName, lastName, eMail: String?
    let mobileNo: NSNull?
    let shippingAddress1, shippingAddress2, shippingCity, shippingZipCode: String?
    let shippingCountry, shippingState, shippingCountryCode, billingAddress1: String?
    let billingAddress2, billingCity, billingZipCode, billingCountry: String?
    let billingState, billingCountryCode: String?
    let shipperName, shipperPhone, shipperAddress: NSNull?
    let paymentType, paymentDetails, promoCode, deliveryType: String?
    let deliveryCharges: Int?
    let subTotalPrice: Double?
    let orderHistoryListData: [OrderHistoryListDatum]?
}


