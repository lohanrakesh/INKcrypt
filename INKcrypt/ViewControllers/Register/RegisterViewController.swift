//
//  RegisterViewController.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 26/03/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit

class RegisterViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = PageTitleStrings.register.localized
    }
    

    //MARK:- Action
    @IBAction func registerButtonClicked(_ sender: UIButton){
       self.pushToRegisterDetailViewController()
    }

}
