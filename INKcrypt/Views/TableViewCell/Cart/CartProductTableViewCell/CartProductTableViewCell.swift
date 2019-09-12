//
//  CartProductTableViewCell.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 3/1/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation
class CartProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var productInfoLabel: UILabel!
    @IBOutlet weak var productQuantityLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!

    var model: CartProduct!
    var indexPath: IndexPath!
    
    func configureCartProductTableViewCell(hideDeleteButton : Bool, cartProduct: CartProduct?) {
        deleteButton.isHidden = hideDeleteButton
        self.model = cartProduct
        self.productTitleLabel.text = model?.productName
        
        if let quantity = model?.quantity {
         self.productQuantityLabel.text = "\(quantity)"
        }
        
        if let price = model?.totalPrice {
            self.costLabel.text = "$ \(price)"
        }
        
        self.productImageView.sd_setImage(with: URL(string: model?.imagePath ?? ""), placeholderImage: UIImage(named: Constants.Images.bannerPlaceholder))
    }
    
    //MARK:- Action
    @IBAction func dropDownButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func plusButtonPressed(_ sender: Any) {
        self.model.quantity += 1
        self.productQuantityLabel.text = "\(self.model.quantity)"
        if let viewC = parentViewController as? CartViewController {
            viewC.callAddtoCart(model: self.model, completion: {
                success in
                if !success {
                    self.model.quantity -= 1
                    self.productQuantityLabel.text = "\(self.model.quantity)"
                }
            })
        }
    }
    
    @IBAction func minusButtonPressed(_ sender: Any) {
        
        if self.model.quantity == 1 {
            return
        }
        self.model.quantity -= 1
        self.productQuantityLabel.text = "\(self.model.quantity)"
        if let viewC = parentViewController as? CartViewController {
            viewC.callAddtoCart(model: self.model, completion: {
                success in
                if !success {
                    self.model.quantity += 1
                    self.productQuantityLabel.text = "\(self.model.quantity)"
                }
            })
        }
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        debugPrint("Delete button clicked")
        if let viewC = parentViewController as? CartViewController {
            viewC.removeFromCart(model: self.model, indexPath: self.indexPath)
        }
    }
}
