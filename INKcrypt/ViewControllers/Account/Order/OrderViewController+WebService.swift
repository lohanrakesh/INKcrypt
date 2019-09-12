//
//  OrderViewController+WebService.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 4/15/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

extension OrderViewController {
    
    func callOrderHistoryAPI() {
        if let user = LoginDetails.getUser() {
            router.serviceForEndPoint(apiType: .getOrderHistoryDetails(model: [Constants.APIParameterKey.userId:String(user.userID)]), decodingType: [OrderList].self) {[weak self] (result) in
                DispatchQueue.main.async {
                    self?.loadingViewController.remove()
                }
                switch result {
                case .success(let responseData, let model):
                    if let response = responseData {
                        if response.success {
                            if let orderArray = model {
                             self?.orderListArray.append(contentsOf: orderArray)
                            }
                        } else {
                            self?.showToastOnTop(message: response.message ?? "OrderHistory API failed")
                        }
                    }
                    
                case .failure(let error):
                    self?.showToastOnTop(message: error.localizedDescription)
                }
            }
        }
    }

    func callOrderHistoryByOrderIDAPI(orderID : Int) {
            if let user = LoginDetails.getUser() {
                router.serviceForEndPoint(apiType: .getOrderHistoryByOrderID(model: [Constants.APIParameterKey.userId:String(user.userID),Constants.APIParameterKey.orderID:orderID]), decodingType: [OrderList].self) {[weak self] (result) in
                    DispatchQueue.main.async {
                        self?.loadingViewController.remove()
                    }
                    switch result {
                    case .success(let responseData, let model):
                        if let response = responseData {
                            if response.success {
                                if let orderArray = model {
                                    self?.orderListArray.append(contentsOf: orderArray)
                                }
                            } else {
                                self?.showToastOnTop(message: response.message ?? "OrderHistory API failed")
                            }
                        }
                        
                    case .failure(let error):
                        self?.showToastOnTop(message: error.localizedDescription)
                    }
                }
            }
    }
}
