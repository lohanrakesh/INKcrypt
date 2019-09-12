//
//  Utility.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 07/03/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit

class Utility: NSObject {

    class func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }

    class func isValidPhoneNumber(value: String) -> Bool {
//        let PHONE_REGEX = "^((\\+)|(00))[0-9]{6,14}$"
//        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
//        let result =  phoneTest.evaluate(with: value)
//        return result
        
        let phoneNumberRegex = "^[6-9]\\d{9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidPhone = phoneTest.evaluate(with: value)
        return isValidPhone
    }
    
    class func hasSpecialCharacters(value: String) -> Bool {
        
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z0-9].*", options: .caseInsensitive)
            if regex.firstMatch(in: value, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, value.count)) != nil {
                return true
            }
            
        } catch {
            debugPrint(error.localizedDescription)
            return false
        }
        
        return false
    }
    
    class func isValidPassword(value: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&#])[A-Za-z\\d$@$!%*?&#]{8,15}"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: value)
    }
    
    class func logAllAvailableFonts() {
        for family in UIFont.familyNames {
            print("\(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                print("   \(name)")
            }
        }
    }
}
