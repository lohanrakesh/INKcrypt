//
//  SavedCardTableViewCell.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 2/26/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation
import SkyFloatingLabelTextField

class SavedCardTableViewCell : UITableViewCell {
   
    @IBOutlet weak var cardNumberTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var validityTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var cardNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var cvvTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var updateButton: UIButton!

    var cardInfo : CardInfo?
    
    
    @IBAction func editButtonPressed(_ sender: Any) {
        if let viewC = self.contentView.parentViewController as? SavedCardViewController {
            viewC.preformCardAction(cardMode: .edit, cardInfo: cardInfo)
        }
    }
    
    func configureSavedCardTableViewCell(cardInfo : CardInfo) {
        //updateButton.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 6.0)
        self.cardInfo = cardInfo
        cardNumberTextField.text = String(cardInfo.cardNumber)
        validityTextField.text = cardInfo.cardValidity
        cardNameTextField.text = cardInfo.name
        cvvTextField.text = cardInfo.cvv
        
    }
    
    
}
