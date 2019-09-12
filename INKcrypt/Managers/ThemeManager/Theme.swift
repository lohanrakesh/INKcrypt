//
//  Theme.swift
//  INKcrypt
//
//  Created by Sandeep Kumar on 29/07/18.
//  Copyright © 2018 Q3 Technologies. All rights reserved.
//

import Foundation
import UIKit

/*
 Useage :- Style.userTheme()
 */

struct Style {
    
    // MARK: Default Theme variables
    
    static var primaryThemeBackgroundColor = UIColor.appDefaultColor()
    static var primaryThemeTextColor = UIColor(red: 242.0 / 255.0, green: 242.0 / 255.0, blue: 242.0 / 255.0, alpha: 1)
    
    // MARK: Loader Color
    static var loaderRingColor = UIColor.appDefaultColor()
    static var loaderBackgroundColor = UIColor.color(withHexCode: "959595")
    
    static func userTheme() {
        // MARK: Theme variables
        let themeColor: UIColor = UIColor.appDefaultColor()
        primaryThemeBackgroundColor = themeColor
        primaryThemeTextColor = UIColor(red: 242.0 / 255.0, green: 242.0 / 255.0, blue: 242.0 / 255.0, alpha: 1)
        kAppDelegate.window?.tintColor = Style.primaryThemeBackgroundColor
        loaderRingColor = themeColor
    }
}
