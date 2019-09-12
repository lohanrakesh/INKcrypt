//
//  SignInViewController.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 20/02/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class SignInViewController: ViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rememberMe: UIImageView!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var rememberMeButton: UIButton!
    
   // lazy var defaults: UserDefaults? = UserDefaults.standard
    
    
    private var viewModel = SignInViewModel()
    
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.initializeView()
    }
    
    // MARK: - Custom Method
    func initializeView() {
        self.signInButton.layer.cornerRadius = 5.0
        self.rememberMeButton.isSelected = viewModel.isSelectedRemmberMeButton
        self.rememberMe.image = viewModel.remmberMeButtonImage
        self.emailTextField.text = viewModel.email
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        if self.navigationController?.viewControllers.count == 1 {
            self.navigationController?.setNavigationBarHidden(true, animated: animated)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK:- Sign in API
    func signInApiCall(){
        add(loadingViewController)
        viewModel.signInApiCall {[weak self] (success, message) in
            DispatchQueue.main.async {
                self?.loadingViewController.remove()
            }
            if(success){
                if let otpVerification = self?.viewModel.loginModel?.otpVerification , otpVerification == true{
                    self?.pushToVerficationCodeViewController()
                }else {
                    self?.dismiss(animated: true, completion: nil)
                }
            }else{
                DispatchQueue.main.async {
                    self?.showToastOnTop(message: message ?? "")
                }
            }
        }
    }
    
    @IBAction func signInButtonClicked(sender: UIButton) {
        self.view.endEditing(true)
        
        let response = viewModel.checkVaildation()
        
        if !response.0 {
            self.showToastOnCenter(message: response.1 ?? AlertMessages.error.localized)
            return
        }
        
        if viewModel.encryptedPassword != nil {
            self.signInApiCall()
        }
    }
    
    @IBAction func rememberMeButtonClicked(sender: UIButton){
        self.view.endEditing(true)
        rememberMeButton.isSelected = !rememberMeButton.isSelected
        if rememberMeButton.isSelected {
            self.rememberMe.image = UIImage.init(named: Constants.Images.selectedCheckbox)
        }else {
            self.rememberMe.image = UIImage.init(named: Constants.Images.buttonSelected)
        }
    }
    
    @IBAction func forgetPasswordButtonClicked(sender: UIButton){
        self.view.endEditing(true)
        self.pushToForgotPasswordViewController()
    }
    
    @IBAction func crossButtonClicked(sender: UIButton){
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpButtonClicked(sender: UIButton){
        self.view.endEditing(true)
        debugPrint("SignUp button clicked")
        self.pushToSignUpViewController()
    }
}


extension SignInViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.emailTextField {
            viewModel.email = textField.text
        }else if textField == self.passwordTextField {
            viewModel.password = textField.text
        }
    }
    
}
