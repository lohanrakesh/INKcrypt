//
//  SignInViewModel.swift
//  INKcrypt
//
//  Created by Sandeep Kumar on 30/08/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation
import RealmSwift

class SignInViewModel {
    let router = Router.sharedInstance
    var isSelectedRemmberMeButton : Bool = false
    var remmberMeButtonImage : UIImage =  UIImage.init(named: "unselected_checkbox")!
    lazy var defaults: UserDefaults? = UserDefaults.standard
    var email : String?
    var password:String?{
        didSet{
            guard let password = password else { return }
            encryptedPassword = password.aesEncrypt()
        }
    }
    var encryptedPassword: String?
    var loginModel : LoginDetails? {
        didSet {
            guard let loginModel = loginModel else { return }
            DispatchQueue.main.async {
                if self.isSelectedRemmberMeButton {
                    self.defaults?.setValue(loginModel.userName, forKey: Constants.kRememberMe)
                }else {
                    self.defaults?.removeObject(forKey: Constants.kRememberMe)
                }
                guard let realm = try? Realm() else {
                    return
                }
                try? realm.write {
                    let user = realm.objects(LoginDetails.self)
                    realm.delete(user)
                    realm.add(loginModel, update: true)
                }
            }
        }
    }
    
    typealias loginResponseCompletion = ((_ success:Bool, _ message:String?) -> Void)
    
    
    init() {
        if let email = defaults?.value(forKey: Constants.kRememberMe) as? String {
            self.isSelectedRemmberMeButton = true
            self.remmberMeButtonImage = UIImage.init(named: Constants.Images.selectedCheckbox)!
            self.email = email
        }
    }
    
    func signInApiCall(completion:@escaping loginResponseCompletion){
        router.serviceForEndPoint(apiType: .login(email: self.email ?? "" , password: self.password ?? ""), decodingType: LoginDetails.self) { [weak self] (result) in
            switch result {
            case .success(let responseData, let model):
                guard let response = responseData else {
                    completion(false, AlertMessages.error.rawValue)
                    return
                }
                if  response.success {
                    if let login = model {
                        self?.loginModel = login
                    }
                    completion(true, nil)
                    
                } else {
                    completion(false, AlertMessages.error.rawValue)
                }
                
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        }
    }
    
    func checkVaildation() -> (Bool,String?) {
        
        if let userName = self.email {
            if (userName.isEmpty) {
                return (false,AlertMessages.enterMail.localized)
            } else if !(Utility.isValidEmail(testStr: userName)) {
                return (false,AlertMessages.validMail.localized)
            }
        } else {
            return (false,AlertMessages.enterMail.localized)
        }
        
        if let password = self.password{
            if (password.isEmpty){
                return (false,AlertMessages.enterPassword.localized)
            } else if password.count < 8 || password.count > 15 {
                return (false,AlertMessages.passwordValidation.localized)
            }
        }else{
            return (false,AlertMessages.enterPassword.localized)
        }
        
        return (true,nil)
        
    }
}
