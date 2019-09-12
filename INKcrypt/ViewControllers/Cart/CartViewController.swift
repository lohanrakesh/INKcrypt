//
//  CartViewController.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 3/1/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

class CartViewController : ViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataInfoLabel: UILabel!
    
    @IBOutlet weak var actionButton: UILocalizedButton!
     @IBOutlet weak var actionButtonView: UIView!
    
    var cartType = CartType.cart
    var cartDetail: CartDetail?
    
    var billingAddress: AddressInfoModel!
    var shippingAddress: AddressInfoModel!
    
    var deliveryTypes = [DeliveryType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitleAndReuseIdentifier()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // tabBarController?.tabBar.isHidden = true
        if self.cartType == .cart {
            self.getCart()
        }else if self.cartType == .checkOut {
            self.getDeliveryType()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //tabBarController?.tabBar.isHidden = false
    }
    
    //MARK:- Custom Method
    
    func getCart() {
        if let user = LoginDetails.getUser(), let model = kAppDelegate.cartInfoModel {
            self.getCartDetailAPI(cartId: model.cartID, userId: user.userID)
        }else if let user = LoginDetails.getUser() {
            self.getCartDetailAPI(cartId: nil, userId: user.userID)
        }else if let model = kAppDelegate.cartInfoModel {
            self.getCartDetailAPI(cartId: model.cartID, userId: nil)
        }
    }
    
    //MARK:- API
    func getCartDetailAPI(cartId: Int?, userId: Int64?) {
        self.add(loadingViewController)
        router.serviceForEndPoint(apiType: .getCart(cartId: cartId, userId: userId), decodingType: CartDetail.self) {[weak self] (result) in
            DispatchQueue.main.async {
                self?.loadingViewController.remove()
                switch result {
                case .success(let responseData, let cartDetail):
                    if let response = responseData {
                        if response.success {
                            if let model = cartDetail {
                                self?.cartDetail = model
                                if let model = self?.cartDetail?.cartDetailData {
                                    kAppDelegate.cartInfoModel = model
                                }
                                self?.updateUI()
                            }
                        } else {
                            self?.popViewController()
                            self?.showToastOnTop(message: response.message ?? "")
                        }
                    }
                case .failure(let error):
                    self?.popViewController()
                    self?.showToastOnTop(message: error.localizedDescription)
                }
            }
        }
    }
    
    func callAddtoCart(model: CartProduct, completion: @escaping (Bool) -> () ) {
        var dict : [String : Any] = [Constants.APIParameterKey.productID : model.productID ,Constants.APIParameterKey.quantity : model.quantity]
        
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
                                self?.cartDetail?.cartDetailData = model
                                if let model = self?.cartDetail?.cartDetailData {
                                    kAppDelegate.cartInfoModel = model
                                }
                                self?.tableView.reloadData()
                                //self?.tableView.reloadRows(at: [IndexPath.init(row: self?.cartDetail?.cartProductListData.count ?? 0, section: 0)], with: .none)
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
    
    func getDeliveryType(){
        router.serviceForEndPoint(apiType: .getDeliveryType, decodingType: [DeliveryType].self) {[weak self] (result) in
            DispatchQueue.main.async {
                self?.loadingViewController.remove()
                switch result {
                case .success(let responseData, let deliveryTypes):
                    if let response = responseData {
                        if response.success {
                            if let model = deliveryTypes {
                                self?.deliveryTypes = model
                            }
                        } else {
                            self?.showToastOnTop(message: response.message ?? "")
                        }
                    }
                case .failure(let error):
                    self?.showToastOnTop(message: error.localizedDescription)
                }
            }
        }
        
    }
    
    func removeFromCart(model: CartProduct, indexPath: IndexPath) {
        var dict : [String : Any] = [Constants.APIParameterKey.productID : model.productID]
        
        if let user = LoginDetails.getUser() {
            dict[Constants.APIParameterKey.userID] = user.userID
        }
        
        if let model = kAppDelegate.cartInfoModel {
            dict[Constants.APIParameterKey.cartID] = model.cartID
        }
        
        debugPrint("Parameter of add to cart:- \(dict)")
        add(loadingViewController)
        router.serviceForEndPoint(apiType: .removeFromCart(model: dict), decodingType: CartInfoModel.self) {[weak self] (result) in
            DispatchQueue.main.async {
                self?.loadingViewController.remove()
                switch result {
                case .success(let responseData, let cartInfoModel):
                    if let response = responseData {
                        if response.success {
                            if let model = cartInfoModel {
                                self?.cartDetail?.cartDetailData = model
                                self?.cartDetail?.cartProductListData.remove(at: indexPath.row)
                                if self?.cartDetail?.cartProductListData.count == 0 {
                                    self?.popViewController()
                                    kAppDelegate.cartInfoModel = nil
                                    return
                                }
                                self?.getCart()
                                /*
                                 self?.tableView.deleteRows(at: [indexPath], with: .fade)
                                 self?.tableView.reloadRows(at: [IndexPath.init(row: self?.cartDetail?.cartProductListData.count ?? 0, section: 0)], with: .none)
                                 */
                            }
                        } else {
                            self?.showToastOnTop(message: response.message ?? "")
                        }
                    }
                case .failure(let error):
                    self?.showToastOnTop(message: error.localizedDescription)
                }
            }
        }
    }
    
    //MARK:- Action
    @IBAction func actionButtonPressed(_ sender: Any) {
        
        switch cartType.rawValue {
        case CartType.confirmOrder.rawValue:
            pushToCartViewController(cartType: .confirmOrder, cartDetail : cartDetail)
            
        case CartType.cart.rawValue:
             pushToCartViewController(cartType: .checkOut, cartDetail:cartDetail)
           
            
        case CartType.checkOut.rawValue:
            pushToCartViewController(cartType: .confirmOrder, cartDetail : cartDetail)
            break
            
        default:
            break
        }
    }
}
