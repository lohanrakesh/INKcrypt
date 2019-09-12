//
//  ContactOwnerViewController.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 18/04/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit

class ContactOwnerViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initializeView()
    }
    
    // MARK: - Custom Method
    
    func initializeView(){
        messageTextView.layer.cornerRadius = 6.0
        messageTextView.layer.borderWidth = 1.0
        messageTextView.layer.borderColor = UIColor.init(red: 213.0/255.0, green: 212.0/255.0, blue: 212.0/255.0, alpha: 1.0).cgColor
    }

    //MARK:- Action
    @IBAction func crossButtonClicked(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitButtonClicked(_ sender: UIButton){
        
    }

}
