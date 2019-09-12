//
//  SignInHeaderView.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 3/7/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

let KSignInHeaderViewNibName = "SignInHeaderView"

class SignInHeaderView :  UITableViewHeaderFooterView {
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: KSignInHeaderViewNibName)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        if let viewC = parentViewController as? AccountViewController {
            viewC.signInAction()
        }
    }
    
}
