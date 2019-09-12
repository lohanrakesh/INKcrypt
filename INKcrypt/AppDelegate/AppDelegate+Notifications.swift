//
//  AppDelegate+Notifications.swift
//  INKcrypt
//
//  Created by Sandeep Kumar on 29/07/18.
//  Copyright © 2018 Q3 Technologies. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

extension AppDelegate {
    // Called when APNs has assigned the device a unique token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Convert token to string
        let deviceTokenString = deviceToken.reduce("", { $0 + String(format: "%02X", $1) })
        // Print it to console
        debugPrint("APNs device token: \(deviceTokenString)")
        // Persist it in your backend in case it's new
        self.registerDeviceToken(deviceToken: deviceTokenString)
    
    }
    
    
    // Called when APNs failed to register the device for push notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Print the error to console (you should alert the user that registration failed)
        debugPrint("APNs registration failed: \(error)")
    }
    
    // Push notification received
    func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable: Any]) {
        // Print notification payload data
        
        debugPrint("Push notification received: \(data)")
        
        _ = data["aps"] as? NSDictionary
        
        let state: UIApplication.State = UIApplication.shared.applicationState
        if state == UIApplication.State.active {
            
            
        } else {
            
        }
    }
 
    
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        return true
    }
    
    func registerForPushNotification(_ application: UIApplication) {
        // iOS 10 support
        if #available(iOS 10, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
                granted, _ in
                debugPrint("Permission granted: \(granted)")
                self.getNotificationSettings()
            }
        }
    }
    
    func getNotificationSettings() {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                debugPrint("Notification settings: \(settings)")
                guard settings.authorizationStatus == .authorized else { return }
                
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        } else {
            // Fallback on earlier versions
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    //MARK:- API
    func registerDeviceToken(deviceToken: String){
        
        var parameter = [Constants.APIParameterKey.uniqueDeviceID: UIDevice.current.identifierForVendor!.uuidString, Constants.APIParameterKey.notificationSenderKey: deviceToken]
        
        if let user = LoginDetails.getUser() {
            parameter[Constants.APIParameterKey.userId] = "\(user.userID)"
        }
        debugPrint("Token Api Parameter :- \(parameter)")
        Router.sharedInstance.serviceForEndPoint(apiType: .deviceToken(dict: parameter), decodingType: ResponseFormat.self) {[weak self] (result) in
            
            switch result {
            case .success(let responseData, _):
                guard let response = responseData else {return}
                if  response.success {
                    print(response.message ?? "Token submit successfully")
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
}
