//
//  UIColorExtension.swift
//  INKcrypt
//
//  Created by Sandeep Kumar on 29/07/18.
//  Copyright © 2018 Q3 Technologies. All rights reserved.
//

import Foundation
import UIKit
extension UIColor {
    
    @nonobjc class var charcoalGrey19: UIColor {
        return UIColor(red: 55.0 / 255.0, green: 62.0 / 255.0, blue: 67.0 / 255.0, alpha: 0.19)
    }
    
    @nonobjc class var cherryRed: UIColor {
        return UIColor(red: 237.0 / 255.0, green: 28.0 / 255.0, blue: 36.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var white: UIColor {
        return UIColor(white: 1.0, alpha: 1.0)
    }
    
    @nonobjc class var brownGrey: UIColor {
        return UIColor(white: 124.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var veryLightPink: UIColor {
        return UIColor(white: 191.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var brownGreyTwo: UIColor {
        return UIColor(white: 164.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var gunmetal: UIColor {
        return UIColor(red: 76.0 / 255.0, green: 81.0 / 255.0, blue: 86.0 / 255.0, alpha: 1.0)
    }
        
    /**
     Returns the UIColor with the hex code provided
     - returns: UIColor
     - parameter String
     - Throws: nil
     */
    class func color(withHexCode: String) -> UIColor {
        var cString = withHexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        cString = cString.replacingOccurrences(of: "#", with: "")
        if cString.count < 6 {
            // Return Default Color
            return UIColor.gray
        }
        if cString.hasPrefix("0X") {
            cString = (cString as NSString).substring(from: 2)
        }
        if cString.count != 6 {
            // Return Default Color
            return UIColor.gray
        }
        var range: NSRange = NSRange()
        range.location = 0
        range.length = 2
        let rString: String = (cString as NSString).substring(with: range)
        range.location = 2
        let gString: String = (cString as NSString).substring(with: range)
        range.location = 4
        let bString: String = (cString as NSString).substring(with: range)
        var red: UInt32 = 0
        var green: UInt32 = 0
        var blue: UInt32 = 0
        
        Scanner(string: rString).scanHexInt32(&red)
        Scanner(string: gString).scanHexInt32(&green)
        Scanner(string: bString).scanHexInt32(&blue)
        
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    class func appDefaultColor() -> UIColor {
        return UIColor.cherryRed
}
}
