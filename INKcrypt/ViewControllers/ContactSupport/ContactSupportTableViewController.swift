//
//  ContactSupportTableViewController.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 15/03/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit

class ContactSupportTableViewController: UITableViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var submitButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initializeView()
    }

    func initializeView(){
        self.tableView.allowsSelection = false
        if let user = LoginDetails.getUser() {
            self.nameTextField.text = user.userName
            self.companyTextField.text = user.companyName
            self.phoneTextField.text = user.userMobileNo
            self.emailTextField.text = user.email
        }
    }

}
