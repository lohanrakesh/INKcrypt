//
//  Constants.swift
//  INKcrypt
//
//  Created by Sandeep Kumar on 26/07/18.
//  Copyright © 2018 Q3 Technologies. All rights reserved.
//

import Foundation
import UIKit

let kAppDelegate = (UIApplication.shared.delegate as? AppDelegate)!

struct Constants {
    
    static let BaseUrl = Constants.apiBaseURL()
    
    
    //USER Default key
    static let kRememberMe = "RememberMe"
    
    
    struct SegueIdentifier {
        static let contactSupport = "ContactSupport"
    }
    
    static func apiBaseURL() -> String {
        debugPrint(ConfigurationManager.sharedManager().applicationEndPoint())
        return ConfigurationManager.sharedManager().applicationEndPoint()
    }
    
    struct APIParameterKey {
        static let productID = "ProductID"
        static let quantity = "Quantity"
        static let cartID = "CartID"
        static let orderID = "OrderID"
        static let cartSessionID = "CartSessionID"
        static let uniqueDeviceID = "UniqueDeviceID"
        static let webURL = "WebURL"
        static let landingURL = "LandingURL"
        static let testKitURL = "TestKitURL"
        static let imageBase64 = "ImageBase64"
        static let nTFCAll = "NTFCAll"
        static let nTFCPassOnly = "NTFCPassOnly"
        static let nTFCFailOnly = "NTFCFailOnly"
        static let nTFCNone = "NTFCNone"
        static let shipAddress1 = "ShipAddress1"
        static let shipAddress2 = "ShipAddress2"
        static let countryName = "countryName"
        static let stateName = "stateName"
        static let cityName = "CityName"
        static let zipcode = "Zipcode"
        static let IsDefault = "IsDefault"
        static let UserId =  "UserId"
        static let addressId = "AddressId"
        
        static let password = "password"
        static let email = "email"
        static let userId = "UserId"
        static let oldPassword = "OldPassword"
        static let newPassword = "NewPassword"
        static let userID = "UserID"
        static let companyInfoId = "CompanyInfoId"
        static let fisrtName = "FisrtName"
        static let lastName = "LastName"
        static let eMail = "EMail"
        static let userMobileNo = "UserMobileNo"
        static let userCountryCode = "UserCountryCode"
        static let companyName = "CompanyName"
        static let companyCountryCode = "CompanyCountryCode"
        static let companyCityName = "CompanyCityName"
        static let areaCode = "AreaCode"
        static let companyPhoneNo = "CompanyPhoneNo"
        static let companyZipcode = "CompanyZipcode"
        static let address1 = "Address1"
        static let address2 = "Address2"
        static let companyStateName = "CompanystateName"
        static let companycountryName = "CompanycountryName"
        
        static let notificationSenderKey = "NotificationSenderKey"
        
    }
    
    struct DeviceType {
        static let deviceType = "ios"
        static let deviceTypeId = "2"
    }
    
    // MARK: - Alert Messages
    struct AlertTitle {
        static let alertTitle = Bundle.main.displayName
    }
    
    struct AlertMessage {
        static let error = AlertMessages.error.localized
        static let invalidEmail = AlertMessages.invalidEmail.localized
        static let comingSoonMessage = AlertMessages.comingSoonMessage.localized
    }
    
    struct Images {
        static let selectedCheckbox = "selected_checkbox"
        static let bannerPlaceholder = "banner_placeholder"
        static let buttonSelected = "buttonSelected"
        static let buttonUnselected = "buttonUnselected"
    }
    
    // MARK: - Date Formats
    struct DateFormats {
        static let dateFormatMMMddhhmma = "MMM dd hh:mm a"
        static let dateFormatInHHMMSS = "yyyy-MM-dd hh:mm:ss aa"
    }
    
    struct Storyboard{
        static let signIn = "SignIn"
        static let authenticate = "Authenticate"
        static let account = "Account"
        static let tab = "Tab"
        static let home = "Home"
        static let register = "Register"
        static let report = "Report"
        static let bioMarkersCodes = "MyBiomarkers"
        static let notification = "Notification"


    }
    
    struct ViewControllerIdentifier {
        
        static let signInViewController = "SignInViewController"
        static let forgotPasswordViewController = "ForgotPasswordViewController"
        static let signUpViewController = "SignUpViewController"
        static let verficationCodeViewController = "VerficationCodeViewController"
        static let patternDetailViewController = "PatternDetailViewController"
        static let testResultViewController = "TestResultViewController"
        static let profileViewController = "ProfileViewController"
        static let orderViewController = "OrderViewController"

        static let savedCardViewController = "SavedCardViewController"
        static let cardViewController = "CardViewController"
        static let cartViewController = "CartViewController"
        static let settingsViewController = "SettingsViewController"
        static let changePasswordViewController = "ChangePasswordViewController"
        static let addressViewController = "AddressViewController"
        static let editAddressViewController = "EditAddressViewController"
        static let aboutViewController = "AboutViewController"
        static let contactSupportViewController = "ContactSupportViewController"
        
        static let tabBarViewController = "TabBarViewController"
        static let registerDetailViewController = "ViewController"
        static let reportViewController = "ReportViewController"
        static let reportDetailViewController = "ReportDetailViewController"
        static let contactOwnerViewController = "ContactOwnerViewController"
        static let myBiomarkersViewController = "MyBiomarkersViewController"
        static let notificationViewController = "NotificationViewController"



    }
    
    struct ImageName {
        static let changePassword = "change_password"
        static let logOut = "log_out"
        static let myProfile = "profile"
        static let orderHistory = "order_history"
        static let address = "address"
        static let savedCard = "saved_card"
        static let myBiomarkersCodes = "my_biomarker"
        static let report = "report"
        static let about = "about"
        static let contactAndSupport = "contact_support"
        static let termsAndConditions = "terms_conditions"
        static let settings = "setrtings_ico"
    }
    
    //    struct StringConstant {
    //        static let logout = "Logout"
    //        static let myProfile = "My Profile"
    //        static let orderHistory = "Order History"
    //        static let address = "Address"
    //        static let savedCard = "Saved Card"
    //        static let myBiomarkersCodes = "My Biomarkers & Codes"
    //        static let report = "Report"
    //        static let about = "About"
    //        static let contactAndSupport = "Contact and Support"
    //        static let termsAndConditions = "Terms and Conditions"
    //        static let settings = "Settings"
    //        static let changePassword = "Change Password"
    //    }
    
    struct CellIdentifier {
        
        static let qrCodeTableViewCell = "QrCodeTableViewCell"
        static let testSuccessTableViewCell = "TestSuccessTableViewCell"
        static let testItemReferenceTableViewCell = "TestItemReferenceTableViewCell"
        static let testFailTableViewCell = "TestFailTableViewCell"
        static let testFailReferenceTableViewCell = "TestFailReferenceTableViewCell"
        
        static let patternDetailTableViewCell = "PatternDetailTableViewCell"
        static let patternImageTableViewCell = "PatternImageTableViewCell"
        static let uploadImageTableViewCell = "UploadImageTableViewCell"
        static let qrProductTableViewCell = "QrProductTableViewCell"
        static let profileTableViewCell = "ProfileTableViewCell"
        static let cartProductTableViewCell = "CartProductTableViewCell"
        static let orderTableViewCell = "OrderTableViewCell"
        static let deliveryTypeTableViewCell = "DeliveryTypeTableViewCell"
        static let editAddressTableViewCell = "EditAddressTableViewCell"
        static let paymentTableViewCell = "PaymentTableViewCell"
        static let editPaymentTableViewCell = "EditPaymentTableViewCell"
        static let cartAddressTableViewCell = "CartAddressTableViewCell"
        static let cartOrderSummaryTableViewCell = "CartOrderSummaryTableViewCell"
        static let cityTableViewCell = "CityTableViewCell"
        static let savedCardTableViewCell = "SavedCardTableViewCell"
        static let addressTableViewCell = "AddressTableViewCell"
        
        static let simpleStoreTableViewCell = "SimpleStoreTableViewCell"
        static let newExistingStoreTableViewCell = "NewExistingStoreTableViewCell"
        static let codeStoreTableViewCell = "CodeStoreTableViewCell"
        static let storeTableViewSection = "StoreTableViewSection"
        
        static let homeHeaderTableViewCell = "HomeHeaderTableViewCell"
        static let homeProductTableViewCell = "HomeProductTableViewCell"
        static let homeReportActivityTableViewCell = "HomeReportActivityTableViewCell"
        
        static let registerDetailTextFieldTableViewCell = "RegisterDetailTextFieldTableViewCell"
        static let registerDetailCodeTableViewCell = "RegisterDetailCodeTableViewCell"
        static let registerDetailSubordinateTableViewCell = "RegisterDetailSubordinateCodeTableViewCell"
        static let registerDetailBatchCertTableViewCell = "RegisterDetailBatchCertTableViewCell"
        static let registerUploadImageTableViewCell = "RegisterUploadImageTableViewCell"
        static let reportTableViewCell = "ReportTableViewCell"
        static let myBiomarkersCodesTableViewCell = "MyBiomarkersCodesTableViewCell"
        static let notificationTableViewCell = "NotificationTableViewCell"
        
        static let contactUsCheckBoxTableViewCell = "ContactUsCheckBoxTableViewCell"
        static let contactUsDetailTableViewCell = "ContactUsDetailTableViewCell"
        
        //Collection Cell
        static let uploadImageCollectionViewCell = "UploadImageCollectionViewCell"
        static let homeHeaderQrCollectionViewCell = "HomeHeaderQrCollectionViewCell"
        static let homeProductCollectionViewCell = "HomeProductCollectionViewCell"
        static let registerDetailImageCollectionViewCell = "RegisterDetailUploadImageCollectionViewCell"
        
    }
}
