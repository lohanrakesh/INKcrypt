//
//  ProfileTableFooterView.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 2/25/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation
let KProfileTableFooterViewNibName = "ProfileTableFooterView"

class ProfileTableFooterView: UIView {
     @IBOutlet weak var updateButton: UIButton!
    
    
    @IBAction func updateButtonPressed(_ sender: Any) {
       
        if let viewC = parentViewController as? ProfileViewController {
            viewC.configureUpdateModel()
            viewC.callSaveProfileAPI()
        }
    }
    
}
