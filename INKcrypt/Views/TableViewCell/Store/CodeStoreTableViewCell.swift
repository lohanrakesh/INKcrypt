//
//  CodeStoreTableViewCell.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 14/03/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit

class CodeStoreTableViewCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productQuantityLabel: UILabel!
    @IBOutlet weak var productCodeTextField: UITextField!
    @IBOutlet weak var itemCodeButton: UIButton!
    @IBOutlet weak var smartQRCodeButton: UIButton!
    
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
        self.itemCodeButton.setImage(UIImage.init(named: Constants.Images.buttonSelected), for: .selected)
        self.itemCodeButton.setImage(UIImage.init(named: Constants.Images.buttonUnselected), for: .normal)
        self.smartQRCodeButton.setImage(UIImage.init(named: Constants.Images.buttonSelected), for: .selected)
        self.smartQRCodeButton.setImage(UIImage.init(named: Constants.Images.buttonUnselected), for: .normal)
        self.itemCodeButton.isSelected = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateUI(){
        self.productNameLabel.text = self.model.productName
       // if let price = self.model.price {
            self.productPriceLabel.text = "$ \(self.model.price)"
        //}
        self.productQuantityLabel.text = "\(self.model.quantityAdded)"
        self.productImageView.sd_setImage(with: URL(string: self.model.imageString ?? ""), placeholderImage: UIImage(named: Constants.Images.bannerPlaceholder))
        self.previousQuantity = self.model.quantityAdded
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
    
    @IBAction func itemCodeButtonClicked(_ sender: UIButton){
        // debugPrint("New button Clicked")
        self.itemCodeButton.isSelected = true
        self.smartQRCodeButton.isSelected = false
        
    }
    
    @IBAction func smartQRCodeButtonClicked(_ sender: UIButton){
        //  debugPrint("Existing button Clicked")
        self.itemCodeButton.isSelected = false
        self.smartQRCodeButton.isSelected = true
        
    }
    
    @IBAction func addButtonClicked(_ sender: UIButton) {
        if let viewC = parentViewController as? StoreViewController {
            viewC.callAddtoCart(model: self.model, completion: {
                success in
                if !success {
                    self.model.quantityAdded = self.previousQuantity
                    self.productQuantityLabel.text = "\(self.model.quantityAdded)"
                }else {
                    self.previousQuantity = self.model.quantity
                }
            })
        }
    }
    
    @IBAction func infoButtonClicked(_ sender: UIButton){
    }
    
}
