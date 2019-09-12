//
//  ForgotPasswordViewController.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 14/03/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: ViewController {
    
    @IBOutlet weak var emailTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func forgotPasswordApiCall(){
        
        guard
            let userName = self.emailTextField.text, !userName.isEmpty, Utility.isValidEmail(testStr: userName) else {
                if (self.emailTextField.text?.isEmpty)! {
                    self.showToastOnTop(message: AlertMessages.enterMail.localized)
                } else if !(Utility.isValidEmail(testStr: self.emailTextField.text!)) {
                    self.showToastOnTop(message: AlertMessages.validMail.localized)
                }
            return
        }
        
        add(loadingViewController)
        router.serviceForEndPoint(apiType: .forgotPassword(email: userName), decodingType: ForgotPassword.self) {[weak self] (result) in
            DispatchQueue.main.async {
                self?.loadingViewController.remove()
            }
            switch result {
            case .success(let responseData, let model):
                guard let response = responseData else {return}
                if  response.success, let message = model?.message {
                    DispatchQueue.main.async {
                       // self?.showToastOnTop(message: message)
                        self?.delay {
                            self?.popViewController()
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.showToastOnTop(message: response.message ?? "")
                    }
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showToastOnTop(message: error.localizedDescription)
                }
            }
        }
    }
    
    // MARK:- Action
    @IBAction func submitButtonClicked(sender: UIButton){
        self.forgotPasswordApiCall()
    }
}
