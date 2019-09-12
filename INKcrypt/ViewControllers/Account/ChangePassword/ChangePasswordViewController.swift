//
//  ChangePasswordViewController.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 2/28/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation
import SkyFloatingLabelTextField

class ChangePasswordViewController : ViewController {
    @IBOutlet weak var oldPasswordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var newPasswordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var confirmPasswordTextField: SkyFloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBarTitle()
    }
    
    private func setNavBarTitle() {
        self.title = PageTitleStrings.changePassword.localized
    }
    
    func checkValidation() -> Bool {
        if oldPasswordTextField.text?.isEmpty ?? true {
            self.showToastOnTop(message: AlertMessages.oldPasswordEmpty.localized)
            return false
        }
        if newPasswordTextField.text?.isEmpty ?? true {
            self.showToastOnTop(message: AlertMessages.newPasswordEmpty.localized)
            return false
        }
        if confirmPasswordTextField.text?.isEmpty ?? true {
            self.showToastOnTop(message: AlertMessages.confirmPasswordEmpty.localized)
            return false
        }
        if let oldPassword = oldPasswordTextField.text , let newPassword = newPasswordTextField.text {
            if oldPassword == newPassword {
                self.showToastOnTop(message: AlertMessages.oldNewPasswordMatch.localized)
                return false
            }
        }
       
        /*
        if self.newPasswordTextField.text!.count != 8 {
            self.showToastOnTop(message: AlertMessages.passwordValidation.localized)
            return false
        }
        if self.confirmPasswordTextField.text!.count != 8 {
            self.showToastOnTop(message: AlertMessages.passwordValidation.localized)
            return false
        }
        */
        
        if self.newPasswordTextField.text != self.confirmPasswordTextField.text {
            self.showToastOnTop(message: AlertMessages.matchingPassword.localized)
            return false
        }
        if self.newPasswordTextField.text!.count < 8 || self.confirmPasswordTextField.text!.count > 15 {
            self.showToastOnCenter(message: AlertMessages.passwordValidation.localized)
            return false
        }
        
        return true
    }
    
    func passwordUpdatedPopup(message : String) {
        let alertController = UIAlertController(title: "Alert",
                                                message: message,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",
                                     style: .default) { _ in
                                        alertController.dismiss(animated: true, completion: nil)
                                        self.popViewController()
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func updateButtonPressed(_ sender: Any) {
        if checkValidation() {
            callChangePasswordAPI()
        }
    }
    
    func callChangePasswordAPI() {
        if let userID = LoginDetails.getUser()?.userID, let oldPassword = oldPasswordTextField.text, let newPassword =  newPasswordTextField.text {
            add(loadingViewController)
            router.serviceForEndPoint(apiType:.changePassword(model: [Constants.APIParameterKey.userId:String(userID)
                ,Constants.APIParameterKey.oldPassword:oldPassword,Constants.APIParameterKey.newPassword:newPassword]), decodingType: Profile.self) {[weak self] (result) in
                    DispatchQueue.main.async {
                        self?.loadingViewController.remove()
                        
                        switch result {
                        case .success(let responseData, _):
                            if let response = responseData, let message = response.message {
                                
                                if response.success {
                                    self?.passwordUpdatedPopup(message: message)
                                } else {
                                    self?.showToastOnTop(message: message)
                                }
                            }
                        case .failure(let error):
                            self?.showToastOnTop(message: error.localizedDescription)
                        }
                    }
            }
        }
    }
}
