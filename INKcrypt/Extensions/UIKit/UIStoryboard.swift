//
//  UIStoryboard.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 21/02/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation


extension UIStoryboard {
    
    class func signInStoryboard() -> UIStoryboard {
         return UIStoryboard.init(name: Constants.Storyboard.signIn, bundle: nil)
    }
    
    class func accountStoryboard() -> UIStoryboard {
        return UIStoryboard.init(name: Constants.Storyboard.account, bundle: nil)
    }
    
    class func authenticateStoryboard() -> UIStoryboard {
        return UIStoryboard.init(name: Constants.Storyboard.authenticate, bundle: nil)
    }
    
    class func tabStoryboard() -> UIStoryboard {
        return UIStoryboard.init(name: Constants.Storyboard.tab, bundle: nil)
    }
    
    class func homeStoryboard() -> UIStoryboard {
        return UIStoryboard.init(name: Constants.Storyboard.home, bundle: nil)
    }
    
    class func registerStoryboard() -> UIStoryboard {
        return UIStoryboard.init(name: Constants.Storyboard.register, bundle: nil)
    }
    
    class func reportStoryboard() -> UIStoryboard {
        return UIStoryboard.init(name: Constants.Storyboard.report, bundle: nil)
    }
    class func bioMarkersCodesStoryboard() -> UIStoryboard {
        return UIStoryboard.init(name: Constants.Storyboard.bioMarkersCodes, bundle: nil)
    }
    class func notificationStoryboard() -> UIStoryboard {
        return UIStoryboard.init(name: Constants.Storyboard.notification, bundle: nil)
    }
}
