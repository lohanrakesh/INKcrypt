//
//  StoreViewController+WebService.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 4/4/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation


extension StoreViewController {
    
    func callAddtoCart(model: ProductDataList, completion: @escaping (Bool) -> () ) {
        var dict : [String : Any] = [Constants.APIParameterKey.productID : model.productID ,Constants.APIParameterKey.quantity : model.quantityAdded]
        
        if let user = LoginDetails.getUser() {
            dict[Constants.APIParameterKey.userID] = user.userID
        }
        
        if let model = kAppDelegate.cartInfoModel {
            dict[Constants.APIParameterKey.cartID] = model.cartID
        }
        
        debugPrint("Parameter of add to cart:- \(dict)")
        
        router.serviceForEndPoint(apiType:.addToCart(model: dict), decodingType: CartInfoModel.self) {[weak self] (result) in
            DispatchQueue.main.async {
                self?.loadingViewController.remove()
                switch result {
                case .success(let responseData, let cartInfoModel):
                    if let response = responseData {
                        if response.success {
                            completion(true)
                            if let model = cartInfoModel {
                                kAppDelegate.cartInfoModel = model
                                self?.updateCartUnreadCount()
                            }
                        } else {
                            completion(false)
                            self?.showToastOnTop(message: response.message ?? "")
                        }
                    }else {
                        completion(false)
                    }
                case .failure(let error):
                    completion(false)
                    self?.showToastOnTop(message: error.localizedDescription)
                }
            }
        }
    }

}
