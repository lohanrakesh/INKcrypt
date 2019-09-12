//
//  CardViewController.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 2/26/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation
import SkyFloatingLabelTextField

enum CardMode {
    case add
    case edit
}
typealias CardCompletionHandler = ((_ cardInfo:CardInfo,_ cardMode : CardMode)->Void)

class CardViewController: ViewController {
    
    @IBOutlet weak var cardNumberTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var validityTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var cvvTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var nameOnCardTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var actionButton: UILocalizedButton!
    
    var cardMode : CardMode = CardMode.add
    var cartInfo : CardInfo?
    var cardCompletionHandler : CardCompletionHandler = {_,_  in }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if cardMode == .add {
            self.actionButton.setTitle("Add", for: .normal)
        } else {
            if let cardModel = cartInfo {
                self.cardNumberTextField.text = String(cardModel.cardNumber)
                self.validityTextField.text = cardModel.cardValidity
                self.cvvTextField.text = cardModel.cvv
                self.nameOnCardTextField.text = cardModel.name
            }
            self.actionButton.setTitle("Update", for: .normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updatedCardInfo(cartInfo : CardInfo?, cardMode : CardMode ,completionerHandler : @escaping CardCompletionHandler) {
        self.cartInfo = cartInfo
        self.cardMode = cardMode
        self.cardCompletionHandler = completionerHandler
    }
    
    func checkValidation() -> Bool {
        if cardNumberTextField.text?.isEmpty ?? true {
            self.present(UIAlertController(title: "Alert", message: "Please enter card number", defaultActionButtonTitle: "OK", tintColor: .blue), animated: true)
            return false
        }
        if validityTextField.text?.isEmpty ?? true {
            self.present(UIAlertController(title: "Alert", message: "Please enter validity", defaultActionButtonTitle: "OK", tintColor: .blue), animated: true)
            return false
        }
        if cvvTextField.text?.isEmpty ?? true {
            self.present(UIAlertController(title: "Alert", message: "Please enter cvv number", defaultActionButtonTitle: "OK", tintColor: .blue), animated: true)
            return false
        }
        if nameOnCardTextField.text?.isEmpty ?? true {
            self.present(UIAlertController(title: "Alert", message: "Please enter card name", defaultActionButtonTitle: "OK", tintColor: .blue), animated: true)
            return false
        }
        return true
    }
    
    @IBAction func actionButtonPressed(_ sender: Any) {
        if checkValidation() {
                if let cardNumberText = cardNumberTextField.text, let cardNumber = Double(cardNumberText), let cardValidity = validityTextField.text, let cvv = cvvTextField.text,let name = nameOnCardTextField.text {
                self.cartInfo = CardInfo(cardNumber: cardNumber, cardValidity:cardValidity, cvv: cvv, name: name)
                if let cartInfoModel = self.cartInfo {
                    self.cardCompletionHandler(cartInfoModel,cardMode)
                }
                popViewController()
            }
        }
    }
}
