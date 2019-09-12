//
//  LocalizedTableNameEnum.swift
//  INKcrypt
//
//  Created by Sandeep Kumar on 28/07/18.
//  Copyright © 2018 Q3 Technologies. All rights reserved.
//

import Foundation

/*
 1. Create String file e.g DataLoader.strings
 2. Add "<key>" = "<value>"; in .strings file
 3. Creating a new enum like DataLoaderStrings below which will contain all the strings of .strings
 4. Usage :"- let string = DataLoaderStrings.loadingData.localized // Loading Data...
 */

protocol Localizable {
    var tableName: String { get }
    var localized: String { get }
}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    var localized: String {
        return rawValue.localized(tableName: tableName)
    }
}

enum DataLoaderStrings: String, Localizable {
    case loadingData = "loading_data"
    case dataLoaded = "data_loaded"
    
    var tableName: String {
        return "DataLoader"
    }
}

enum Login: String, Localizable {
   case userName =  "user_name"
   case password = "password"
   case signin = "sign_in"

    var tableName: String {
        return "Login"
    }
}

enum AlertMessages: String, Localizable {
    case error
    case oldPasswordEmpty
    case newPasswordEmpty
    case confirmPasswordEmpty
    case oldNewPasswordMatch

    case invalidEmail
    case comingSoonMessage
    case enterMailPhone
    case mailPhoneValidation
    case enterPassword
    case passwordValidation
    case enterFirstName
    case enterLastName
    case firstNameSpecialChar
    case lastNameSpecialChar
    case enterMail
    case validMail
    case enterMobileNumber
    case mobileZeroPrefix
    case enterMobileCode
    case validMobileNumber
    case enterRePassword
    case matchingPassword
    case enterName
    case enterCompany
    case enterDescription
    case enterQRCode
    case alertTitle
    case sessionExpire
    case alertOk
    case alertLogin
    case startKit
    case login
    
    var tableName: String {
        return "AlertMessages"
    }
}

enum PageTitleStrings: String, Localizable {
    case orderDetails
    case myOrder
    case account
    case profile
    case setting
    case changePassword
    case addressBook
    case addAddress
    case updateAddress
    case test
    case forgotPassword = "forgotPassword"
    case home = "home"
    case filters = "filters"
    case cart = "cart"
    case checkout = "checkout"
    case countryAndLanguage = "countryAndLanguage"

    case updatePassword = "updatePassword"
    case authentication = "authentication"
    case about = "about"
    case termAndCondition = "Terms And Condition"
    case register = "register"
    case store = "store"
    case report
    case myBiomarkers
    case notification
    
    var tableName: String {
        return "PageTitleStrings"
    }
}

enum AccountConstant: String, Localizable {
    case logout
    case myProfile
    case orderHistory
    case address
    case savedCard
    case myBiomarkersCodes
    case report
    case about
    case contactAndSupport
    case termsAndConditions
    case settings
    case changePassword
    var tableName: String {
        return "Account"
    }
}

enum LocalizableString: String, Localizable {
    
    case startKit
    
    var tableName: String {
        return "Localizable"
    }
}
