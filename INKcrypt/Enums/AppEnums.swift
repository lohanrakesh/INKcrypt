//
//  AppEnums.swift
//  INKcrypt
//
//  Created by Sandeep Kumar on 29/07/18.
//  Copyright © 2018 Q3 Technologies. All rights reserved.
//

import Foundation
enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
enum ProfilePersonalInfo : Int {
    case firstName = 0
    case lastName = 1
    case email = 2
    case phoneNumber = 3
    
    var discription : String {
        switch self {
        case .firstName:
            return "First Name"
        case .lastName:
            return "Last Name"
        case .email:
            return "Email"
        case .phoneNumber:
            return "Phone Number"
        }
    }
}

enum ProfileCompanyInfo : Int {
    case name = 0
    case phoneNumber = 1
    case addressLine1 = 2
    case addressLine2 = 3
    case country = 4
    case city = 5
    case zipCode = 6
    
    var discription : String {
        switch self {
        case .name:
            return "Name"
        case .phoneNumber:
            return "Phone Number"
        case .addressLine1:
            return "Address Line 1"
        case .addressLine2:
            return "Address Line 2"
        case .country:
            return "Country"
        case .city:
            return "City"
        case .zipCode:
            return "Zip Code"
        }
    }
}

enum CartType : Int {
    case cart = 0
    case confirmOrder = 1
    case checkOut = 2
}

enum ScreenType {
    case add
    case edit
}

enum TestType {
    case fail
    case success
}

enum CheckoutSection : Int {
    case shippingAddress = 0
    case billingAddress = 1
    case deliveryType = 2
    case payment = 3
    
    var discription : String {
        switch self {
        case .shippingAddress:
            return "SHIPPING ADDRESS"
        case .billingAddress:
            return "BILLING ADDRESS"
        case .deliveryType:
            return "DELIVERY TYPE"
        case .payment:
            return "PAYMENT"
        }
    }
}

enum WebViewAction {
    case about
    case termAndCondition
}

enum AccountInfo : Int {
    case myProfile = 0
    case orderHistory = 1
    case address = 2
    case savedCard = 3
    case myBiomarkersCodes = 4
    case report = 5
    case settings = 6
    case about = 7
    case contactAndSupport = 8
    case termsAndConditions = 9
    case changePassword = 10
    case logout = 11
   
    
    var discription : String {
        switch self {
        case .myProfile:
            return AccountConstant.myProfile.localized
        case .orderHistory:
            return AccountConstant.orderHistory.localized
        case .address:
            return AccountConstant.address.localized
        case .savedCard:
            return AccountConstant.savedCard.localized
        case .myBiomarkersCodes:
            return AccountConstant.myBiomarkersCodes.localized
        case .report:
            return AccountConstant.report.localized
        case .about:
            return AccountConstant.about.localized
        case .contactAndSupport:
            return AccountConstant.contactAndSupport.localized
        case .termsAndConditions:
            return AccountConstant.termsAndConditions.localized
        case .settings:
            return AccountConstant.settings.localized
        case .changePassword:
            return AccountConstant.changePassword.localized
        case .logout:
            return AccountConstant.logout.localized
        }
    }
    
    var imageName : String {
        switch self {
        case .myProfile:
            return Constants.ImageName.myProfile
        case .orderHistory:
            return Constants.ImageName.orderHistory
        case .address:
            return Constants.ImageName.address
        case .savedCard:
            return Constants.ImageName.savedCard
        case .myBiomarkersCodes:
            return Constants.ImageName.myBiomarkersCodes
        case .report:
            return Constants.ImageName.report
        case .about:
            return Constants.ImageName.about
        case .contactAndSupport:
            return Constants.ImageName.contactAndSupport
        case .termsAndConditions:
            return Constants.ImageName.termsAndConditions
        case .settings:
            return Constants.ImageName.settings
        case .changePassword:
            return Constants.ImageName.changePassword
        case .logout:
            return Constants.ImageName.logOut
        }
    }
    
}
