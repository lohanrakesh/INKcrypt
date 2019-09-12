//
//  AccountViewController+WebService.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 3/29/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation
import RealmSwift

extension AccountViewController {
    func callLogoutAPI() {
        if let user = LoginDetails.getUser() {
            add(loadingViewController)
            
            let dict = [Constants.APIParameterKey.UserId:user.userID,Constants.APIParameterKey.uniqueDeviceID : UIDevice.current.identifierForVendor!.uuidString] as [String : Any]
            router.serviceForEndPoint(apiType: .logout(model: dict), decodingType: Profile.self) {[weak self] (result) in
                DispatchQueue.main.async {
                    self?.loadingViewController.remove()
                    switch result {
                    case .success(let responseData, _):
                        if let response = responseData {
                            if response.success {
                                self?.clearRealmDataBase()
                            } else {
                                self?.showToastOnTop(message: response.message ?? "Logout API failed")
                            }
                        }
                    case .failure(let error):
                        self?.showToastOnTop(message: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func clearRealmDataBase() {
        kAppDelegate.cartInfoModel = nil
        guard let realm = try? Realm() else { return }
        try? realm.write {
            realm.deleteAll()
        }
        reloadTableView()
    }
    
    
}
