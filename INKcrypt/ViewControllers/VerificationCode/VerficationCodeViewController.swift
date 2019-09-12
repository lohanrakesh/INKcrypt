//
//  VerficationCodeViewController.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 21/02/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit
import SVPinView

class VerficationCodeViewController: ViewController {
    
   // @IBOutlet weak var verificatioCodeTextField: UITextField!
    
    @IBOutlet weak var verificatioCodeView: SVPinView!
    @IBOutlet weak var verifyCodeButton: UIButton!
    
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.initializeView()
    }
    
    // MARK: - Custom Method
    func initializeView() {
        self.verifyCodeButton.layer.cornerRadius = 5.0
        self.verificatioCodeView.style = .box
        self.verificatioCodeView.fieldCornerRadius = 4.0
        
        self.verificatioCodeView.didFinishCallback = { pin in
            debugPrint("The pin entered is \(pin)")
        }
        self.verificatioCodeView.didChangeCallback = { pin in
           debugPrint("The pin changed is \(pin)")
        }
        
        self.getVerificationCodeApiCall()
    }
    
    func getVerificationCodeApiCall(){
        
        if let user = LoginDetails.getUser() {
            
            add(loadingViewController)
            self.router.serviceForEndPoint(apiType: .verificationCode(userId: "\(user.userID)"), decodingType: VerificationCode.self) { [weak self] result in
                DispatchQueue.main.async {
                    self?.loadingViewController.remove()
                }
                switch result {
                case .success(let responseData, let model):
                    guard let response = responseData else {return}
                    
                    if  response.success {
                        if let object = model, let otp =  object.mobileOTP{
                            DispatchQueue.main.async {
                               // self?.verificatioCodeTextField.text = "\(otp)"
                                self?.verificatioCodeView.pastePin(pin: "\(otp)")
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
            //        self.networkClient.getVerificationCode(userId: "\(user.userID)"){[weak self] (verificationCode, success, message) in
            //            DispatchQueue.main.async {
            //                self?.loadingViewController.remove()
            //            }
            //            if success, let code = verificationCode {
            //                DispatchQueue.main.async {
            //                    self?.verificatioCodeTextField.text = "\(code)"
            //                }
            //            }else if let message = message {
            //                debugPrint(message)
            //                self?.showToastOnTop(message: message)
            //            }
            //        }
        }
    }
    
    func verifyCodeApiCall(){
        
        if let user = LoginDetails.getUser() {
            let OTP = self.verificatioCodeView.getPin()
            add(loadingViewController)
            self.router.serviceForEndPoint(apiType: Api.verifyOTP(userId: "\(user.userID)", OTP: OTP), decodingType: VerificationCode.self) { [weak self] result in
                DispatchQueue.main.async {
                    self?.loadingViewController.remove()
                }
                switch result {
                case .success(let responseData, _):
                    guard let response = responseData else {return}
                    
                    if  response.success {
                        DispatchQueue.main.async {
                            self?.showToastOnTop(message: response.message ?? "")
                            self?.delay {
                               // self?.pushToTabBarViewController()
                                self?.dismiss(animated: true, completion: nil)
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
            
            
//            self.networkClient.verifyCode(userId: "\(user.userID)", OTP: OTP){[weak self] ( success, message) in
//                DispatchQueue.main.async {
//                    self?.loadingViewController.remove()
//                }
//                if success, let strMessage = message {
//                    DispatchQueue.main.async {
//                        self?.showToastOnCenter(message: strMessage)
//                        self?.delay {
//                            self?.pushToHomeViewController()
//                        }
//                    }
//                }else if let message = message {
//                    debugPrint(message)
//                    self?.showToastOnTop(message: message)
//                }
//            }
        }
    }
    
    // MARK: - Action
    @IBAction func verifyCodeButtonClicked(sender: UIButton){
//        if #available(iOS 12.0, *) {
//            self.verificatioCodeTextField.textContentType = .oneTimeCode
//        }
        self.verifyCodeApiCall()
    }
    
    @IBAction func resendCodeButtonClicked(sender: UIButton){
        self.getVerificationCodeApiCall()
    }
    
}
