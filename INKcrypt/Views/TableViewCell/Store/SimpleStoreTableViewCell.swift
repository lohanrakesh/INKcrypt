//
//  SimpleStoreTableViewCell.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 14/03/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit
import SDWebImage

class SimpleStoreTableViewCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productQuantityLabel: UILabel!
    
    var model: ProductDataList!{
        didSet{
            self.updateUI()
        }
    }
    var previousQuantity = 1
    
    //MARK:- View Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateUI(){
        self.productNameLabel.text = self.model.productName
        //if let price = self.model.price {
            self.productPriceLabel.text = "$ \(self.model.price)"
        //}
        self.productQuantityLabel.text = "\(self.model.quantityAdded)"
        self.productImageView.sd_setImage(with: URL(string: self.model.imageString ?? ""), placeholderImage: UIImage(named: Constants.Images.bannerPlaceholder))
        self.previousQuantity = self.model.quantityAdded
    }
    
    func callAddToCart(){
        
        if let viewC = parentViewController as? StoreViewController {
            viewC.callAddtoCart(model: self.model, completion: {
                success in
                if !success {
                    self.model.quantityAdded = self.previousQuantity
                    self.productQuantityLabel.text = "\(self.model.quantityAdded)"
                }else {
                    
                    if self.model.productID == 4 {

                        kAppDelegate.isStartKitAddedToCart = true
                        viewC.tableView.reloadData()
                    }else {
                        self.previousQuantity = self.model.quantity
                    }
                }
            })
        }
    }
    
    //MARK:- Action
    @IBAction func plusButtonClicked(_ sender: UIButton){
        // debugPrint("Plus button Clicked")
        if self.model.availableQuantity == self.model.quantityAdded {
            return
        }
        self.model.quantityAdded += 1
        self.productQuantityLabel.text = "\(self.model.quantityAdded)"
//        if let vc = parentViewController as? StoreViewController {
//            vc.callAddtoCart(model: self.model, completion: {
//                success in
//                if !success {
//                    self.model.quantityAdded -= 1
//                    self.productQuantityLabel.text = "\(self.model.quantityAdded)"
//                }
//            })
//        }
    }
    
    @IBAction func minusButtonClicked(_ sender: UIButton){
        // debugPrint("Minus button Clicked")
        if self.model.quantityAdded == 1 {
            return
        }
        self.model.quantityAdded -= 1
        self.productQuantityLabel.text = "\(self.model.quantityAdded)"
//        if let vc = parentViewController as? StoreViewController {
//            vc.callAddtoCart(model: self.model, completion: {
//                success in
//                if !success {
//                    self.model.quantityAdded += 1
//                    self.productQuantityLabel.text = "\(self.model.quantityAdded)"
//                }
//            })
//        }
    }
    
    @IBAction func addButtonClicked(_ sender: UIButton){
        
        if self.model.productID == 4 {
            self.callAddToCart()
        }else {
            if let user = LoginDetails.getUser(){
                
                if !(user.isStarterKit) && !(kAppDelegate.isStartKitAddedToCart) {
                    if let viewC = parentViewController as? StoreViewController {
                        viewC.showToastOnCenter(message: AlertMessages.startKit.localized)
                        return
                    }
                }else {
                    if kAppDelegate.isStartKitAddedToCart {
                        self.callAddToCart()
                    }else {
                        if let viewC = parentViewController as? StoreViewController {
                            viewC.showToastOnCenter(message: AlertMessages.startKit.localized)
                            return
                        }
                    }
                }
            }else {
                if kAppDelegate.isStartKitAddedToCart {
                    self.callAddToCart()
                }else {
                    if let viewC = parentViewController as? StoreViewController {
                        viewC.showToastOnCenter(message: AlertMessages.startKit.localized)
                        return
                    }
                }
            }
        }
    }
    
    @IBAction func infoButtonClicked(_ sender: UIButton){
        
    }
}
