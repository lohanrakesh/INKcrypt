//
//  SignUpViewController.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 21/02/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit
import RealmSwift

class SignUpViewController: ViewController{
    
    var viewModel = SignUpViewModel()
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var mobileNumberCodeTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rePasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    var pickerView = UIPickerView()
    
    //var countryCodeArray = [CountryCode]()
    
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        self.initializeView()
    }
    
    // MARK: - Custom Method
    func initializeView() {
        self.signUpButton.layer.cornerRadius = 5.0
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.mobileNumberCodeTextField.inputView = self.pickerView
        self.getCountryCodeApiCall()
    }
    
    //MARK:- API
    func getCountryCodeApiCall(){
        add(loadingViewController)
        viewModel.getCountryCodeApiCall { [weak self](success, message) in
            DispatchQueue.main.async {
                self?.loadingViewController.remove()
            }
            if(success){
                
            }else{
                DispatchQueue.main.async {
                    self?.showToastOnTop(message: message ?? "")
                }
            }
        }
    }
    
    func showToast(){
        if (self.firstNameTextField.text?.isEmpty)! {
            self.showToastOnCenter(message: AlertMessages.enterFirstName.localized)
        }else if let firstName = self.firstNameTextField.text , Utility.hasSpecialCharacters(value: firstName) {
            self.showToastOnCenter(message: AlertMessages.firstNameSpecialChar.localized)
        } else if (self.lastNameTextField.text?.isEmpty)! {
            self.showToastOnCenter(message: AlertMessages.enterLastName.localized)
        } else if let lastName = self.lastNameTextField.text , Utility.hasSpecialCharacters(value: lastName) {
            self.showToastOnCenter(message: AlertMessages.lastNameSpecialChar.localized)
        } else if (self.emailTextField.text?.isEmpty)! {
            self.showToastOnCenter(message: AlertMessages.enterMail.localized)
        } else if !(Utility.isValidEmail(testStr: self.emailTextField.text!)) {
            self.showToastOnCenter(message: AlertMessages.validMail.localized)
        }else if (self.mobileNumberCodeTextField.text?.isEmpty)! {
            self.showToastOnCenter(message: AlertMessages.enterMobileCode.localized)
        }else if (self.mobileNumberTextField.text?.isEmpty)! {
            self.showToastOnCenter(message: AlertMessages.enterMobileNumber.localized)
        } else {
            self.showToast1()
        }
    }
    
    
    func showToast1(){
        if self.mobileNumberTextField.text?.hasPrefix("0") ?? false {
            self.showToastOnCenter(message: AlertMessages.mobileZeroPrefix.localized)
        } else if !(Utility.isValidPhoneNumber(value: self.mobileNumberTextField.text!)) {
            self.showToastOnCenter(message: AlertMessages.validMobileNumber.localized)
        } else if (self.passwordTextField.text?.isEmpty)! {
            self.showToastOnCenter(message: AlertMessages.enterPassword.localized)
        } else if !(Utility.isValidPassword(value: self.passwordTextField.text!)) {
            self.showToastOnCenter(message: AlertMessages.passwordValidation.localized)
        } else if (self.rePasswordTextField.text?.isEmpty)! {
            self.showToastOnCenter(message: AlertMessages.enterRePassword.localized)
        }
    }
    
    func signUpApiCall(){
        add(loadingViewController)
        
        viewModel.signUpApiCall {[weak self] (success, message) in
            DispatchQueue.main.async {
                self?.loadingViewController.remove()
            }
            
            if(success){
                do {
                    let realm = try Realm()
                    if let user = realm.objects(LoginDetails.self).first {
                        if user.otpVerification {
                            self?.pushToVerficationCodeViewController()
                        }else {
                            self?.dismiss(animated: true, completion: nil)
                        }
                    }else{
                        DispatchQueue.main.async {
                            self?.showToastOnTop(message: AlertMessages.error.rawValue)
                        }
                    }
                }catch {
                    debugPrint("Realm istance not created")
                    DispatchQueue.main.async {
                        self?.showToastOnTop(message: AlertMessages.error.rawValue)
                    }
                }
                
                
            }else{
                DispatchQueue.main.async {
                    self?.showToastOnTop(message: message ?? "")
                }
            }
            
        }
        
        
    }
    
    // MARK: - Action
    @IBAction func signUpButtonClicked(sender: UIButton) {
        self.view.endEditing(true)
        do {
            _ = try emailTextField.validatedText(validationType: ValidatorType.email)
            _ = try firstNameTextField.validatedText(validationType: ValidatorType.name)
            _ = try mobileNumberCodeTextField.validatedText(validationType: .requiredField(field: "Country Code"))
            _ = try mobileNumberCodeTextField.validatedText(validationType: .requiredField(field: "Mobile Number"))
            _ = try mobileNumberCodeTextField.validatedText(validationType: ValidatorType.mobile)
            _ = try passwordTextField.validatedText(validationType: ValidatorType.password)
            _ = try rePasswordTextField.validatedText(validationType: ValidatorType.password)
        } catch(let error) {
            self.showToastOnCenter(message:(error as! ValidationError).message)
            return
        }
        
        if self.passwordTextField.text != self.rePasswordTextField.text {
            self.showToastOnCenter(message: AlertMessages.matchingPassword.localized)
            return
        }
        
        self.signUpApiCall()
    }
    
    
    
    
}

extension SignUpViewController:UIPickerViewDelegate,UIPickerViewDataSource {
    //MARK:- UIPickerDelegate
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return self.viewModel.countryCodeArray.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.viewModel.countryCodeArray[row].text
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if !self.viewModel.countryCodeArray.isEmpty {
            self.mobileNumberCodeTextField.text = self.viewModel.countryCodeArray[row].text
        }
        // pickerView.isHidden = true
    }
}

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.mobileNumberCodeTextField {
            pickerView.isHidden = false
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.firstNameTextField {
            viewModel.firstName = textField.text
        }else if textField == self.lastNameTextField {
            viewModel.lastName = textField.text
        }else if textField == self.emailTextField {
            viewModel.email = textField.text
        }else if textField == self.mobileNumberCodeTextField {
            viewModel.mobileNumberCode = textField.text
        }else if textField == self.mobileNumberTextField {
            viewModel.mobileNumber = textField.text
        }else if textField == self.passwordTextField {
            viewModel.password = textField.text
        }else if textField == self.rePasswordTextField {
            viewModel.rePassword = textField.text
        }
    }
    
}
