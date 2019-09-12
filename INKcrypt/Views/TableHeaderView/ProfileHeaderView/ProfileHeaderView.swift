//
//  ProfileHeaderView.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 2/25/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation
let KProfileTableHeaderViewNibName = "ProfileHeaderView"

class ProfileHeaderView: UITableViewHeaderFooterView {

     @IBOutlet weak var infoLabel: UILabel!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: KProfileTableHeaderViewNibName)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configureProfileHeaderView(section : Int) {
        if section == 0 {
            infoLabel.text = "PERSONAL INFO"
        } else {
            infoLabel.text = "COMPANY INFO"
        }
    }
    
    func configureAddressHeaderView(section : Int) {
        if section == 0 {
            infoLabel.text = "DEFAULT ADDRESS"
        } else {
            infoLabel.text = "OTHER ADDRESS"
        }
    }
    
    func configureSectionHeader(text : String) {
        infoLabel.text = text
    }
}
