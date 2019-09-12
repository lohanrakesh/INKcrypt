//
//  NewExistingStoreTableViewCell.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 14/03/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit
import RealmSwift

class NewExistingStoreTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productQuantityLabel: UILabel!
    @IBOutlet weak var productStatusTextField: UITextField!
    @IBOutlet weak var productBioMarkerIDTextField: UITextField!
    @IBOutlet weak var newButton: UIButton!
    @IBOutlet weak var existingButton: UIButton!
    @IBOutlet weak var biomarkerIDViewHeight: NSLayoutConstraint!
    @IBOutlet weak var biomarkerIDView: UIView!
    
    var model: ProductDataList!{
        didSet{
            self.updateUI()
        }
    }
    
    var isStartkitAdd = false
    
    var previousQuantity = 1
    
    //MARK:- View Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.biomarkerIDViewHeight.constant = 0.0
        
        self.newButton.setImage(UIImage.init(named: Constants.Images.buttonSelected), for: .selected)
        self.newButton.setImage(UIImage.init(named: Constants.Images.buttonUnselected), for: .normal)
        self.existingButton.setImage(UIImage.init(named: Constants.Images.buttonSelected), for: .selected)
        self.existingButton.setImage(UIImage.init(named: Constants.Images.buttonUnselected), for: .normal)
        
        if let user = LoginDetails.getUser(), !(user.isStarterKit) {
            
            if kAppDelegate.isStartKitAddedToCart {
                self.existingButtonSetup()
                self.productBioMarkerIDTextField.text = LocalizableString.startKit.localized
                self.productBioMarkerIDTextField.isUserInteractionEnabled = false
            }else {
                self.newButtonSetup()
            }
        }else {
            self.newButtonSetup()
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateUI(){
        self.productNameLabel.text = self.model.productName
        //if let price = self.model.price {
        self.productPriceLabel.text = "$ \(self.model.price )"
        //}
        self.productQuantityLabel.text = "\(self.model.quantityAdded)"
        self.productImageView.sd_setImage(with: URL(string: self.model.imageString ?? ""), placeholderImage: UIImage(named: Constants.Images.bannerPlaceholder))
        self.previousQuantity = self.model.quantityAdded
    }
    
    func existingButtonSetup(){
        self.newButton.isSelected = false
        self.existingButton.isSelected = true
        self.biomarkerIDViewHeight.constant = 48.0
        self.biomarkerIDView.isHidden = false
    }
    
    func newButtonSetup(){
        self.newButton.isSelected = true
        self.existingButton.isSelected = false
        self.biomarkerIDViewHeight.constant = 0.0
        self.biomarkerIDView.isHidden = true
    }
    
    func callAddToCart(){
        
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
    
    @IBAction func newButtonClicked(_ sender: UIButton){
        // debugPrint("New button Clicked")
        if let user = LoginDetails.getUser(), !(user.isStarterKit) {
            if kAppDelegate.isStartKitAddedToCart {
                return
            }else {
                if let viewC = parentViewController as? StoreViewController {
                    viewC.showToastOnCenter(message: AlertMessages.startKit.localized)
                    return
                }
            }
        }
        self.newButtonSetup()
        if let viewC = parentViewController as? StoreViewController {
            viewC.tableView.beginUpdates()
            viewC.tableView.endUpdates()
        }
    }
    
    @IBAction func existingButtonClicked(_ sender: UIButton){
        //  debugPrint("Existing button Clicked")
        if LoginDetails.getUser() != nil {
            self.existingButtonSetup()
            if let viewC = parentViewController as? StoreViewController {
                viewC.tableView.beginUpdates()
                viewC.tableView.endUpdates()
            }
        }else {
            
            if let viewC = parentViewController as? StoreViewController {
                
                let alertVC = UIAlertController.init(title: "", message: AlertMessages.login.localized, preferredStyle: .alert)
                alertVC.addAction(UIAlertAction.init(title: AlertMessages.alertOk.localized, style: .default, handler: nil))
                alertVC.addAction(title: AlertMessages.alertLogin.localized, style: .default) { (_) in
                    let signInViewController = UIStoryboard.signInStoryboard().instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.signInViewController)
                    let nav = UINavigationController.init(rootViewController: signInViewController)
                    viewC.present(nav, animated: true, completion: nil)
                }
                viewC.present(alertVC, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func addButtonClicked(_ sender: UIButton){
        
        if let user = LoginDetails.getUser(){
            
            if !(user.isStarterKit) && !(kAppDelegate.isStartKitAddedToCart) {
                if let viewC = parentViewController as? StoreViewController {
                    viewC.showToastOnCenter(message: AlertMessages.startKit.localized)
                    return
                }
            }else {
                self.callAddToCart()
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
    
    @IBAction func infoButtonClicked(_ sender: UIButton){
        
    }
    
}
