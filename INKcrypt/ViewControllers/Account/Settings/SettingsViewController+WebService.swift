//
//  SettingsViewController+WebService.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 3/25/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

extension SettingsViewController {
    
    func isValidUrl(url: String?) -> Bool {
        if url?.isEmpty ?? true {return true}
        let urlRegEx = "^(https?://)?(www\\.)?([-a-z0-9]{1,63}\\.)*?[a-z0-9][-a-z0-9]{0,61}[a-z0-9]\\.[a-z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$"
        let urlTest = NSPredicate(format:"SELF MATCHES %@", urlRegEx)
        let result = urlTest.evaluate(with: url)
        return result
    }
    
    func checkValidation() -> (Bool,[String:Any]?) {
        var dict : [String:Any] = [:]
        
        if companyWebsiteTextField.text?.isEmpty ?? true { self.present(UIAlertController(title: "Alert", message: "Please enter Company Website URL", defaultActionButtonTitle: "OK", tintColor: .blue), animated: true)
            return (false,nil)
        }
        
        if isValidUrl(url: companyWebsiteTextField.text) {
            dict[Constants.APIParameterKey.webURL] = companyWebsiteTextField.text
        } else {
            self.present(UIAlertController(title: "Alert", message: "Please enter Valid Company Website URL", defaultActionButtonTitle: "OK", tintColor: .blue), animated: true)
            return (false,nil)
        }
        /*
        if pageURLTextField.text?.isEmpty ?? true {self.present(UIAlertController(title: "Alert", message: "Please enter page URL", defaultActionButtonTitle: "OK", tintColor: .blue), animated: true)
            return (false,nil)} */
            
        
        if isValidUrl(url:pageURLTextField.text) {
            dict[Constants.APIParameterKey.landingURL] = pageURLTextField.text
        } else {
            self.present(UIAlertController(title: "Alert", message: "Please enter Valid page URL", defaultActionButtonTitle: "OK", tintColor: .blue), animated: true)
            return (false,nil)
       
        }
        /*
        if kitURLTextField.text?.isEmpty ?? true {self.present(UIAlertController(title: "Alert", message: "Please enter Kit URL", defaultActionButtonTitle: "OK", tintColor: .blue), animated: true)
            return (false,nil)}
        */
        
        if isValidUrl(url: kitURLTextField.text) {
            dict[Constants.APIParameterKey.testKitURL] = kitURLTextField.text
        } else {
            self.present(UIAlertController(title: "Alert", message: "Please enter Valid Kit URL", defaultActionButtonTitle: "OK", tintColor: .blue), animated: true)
            return (false,nil)
        }
        
        if !allButton.isSelected && !failOnlyButton.isSelected && !passOnlyButton.isSelected && !noneButton.isSelected {
            self.present(UIAlertController(title: "Alert", message: "Please select test result notification type", defaultActionButtonTitle: "OK", tintColor: .blue), animated: true)
            return (false,nil)
        }
        
        if photoImageView.image != nil {
            appendBase64ImageData(param: &dict)
        } else {
            self.present(UIAlertController(title: "Alert", message: "Please select image", defaultActionButtonTitle: "OK", tintColor: .blue), animated: true)
            return (false,nil)
        }
        
        dict[Constants.APIParameterKey.userID] = LoginDetails.getUser()!.userID
        
        return (true,dict)
    }
    
    func appendBase64ImageData( param : inout [String:Any]) {
        if let image = photoImageView.image, let compressedImage = image.resized(toWidth: 150), let base64String = compressedImage.toBase64() {
            param[Constants.APIParameterKey.imageBase64] = base64String
        }
        if allButton.isSelected {
            param[Constants.APIParameterKey.nTFCAll] = true
        } else {
            param[Constants.APIParameterKey.nTFCAll] = false
        }
        if failOnlyButton.isSelected {
            param[Constants.APIParameterKey.nTFCFailOnly] = true
        } else {
            param[Constants.APIParameterKey.nTFCFailOnly] = false
        }
        if passOnlyButton.isSelected {
            param[Constants.APIParameterKey.nTFCPassOnly] = true
        } else {
            param[Constants.APIParameterKey.nTFCPassOnly] = false
        }
        if noneButton.isSelected {
            param[Constants.APIParameterKey.nTFCNone] = true
        } else {
            param[Constants.APIParameterKey.nTFCNone] = false
        }
    }
    
    func callSaveUserSettingAPI() {
        if checkValidation().0 {
            add(loadingViewController)
            guard let dict = checkValidation().1 else {return}
            router.serviceForEndPoint(apiType: .saveUserAppSetting(model : dict), decodingType: UserSettingModel.self) {[weak self] (result) in
                DispatchQueue.main.async {
                    self?.loadingViewController.remove()
                    switch result {
                    case .success(let responseData, _):
                        guard let response = responseData  else {return}
                        if !response.success {
                            self?.showToastOnTop(message: response.message ?? "")
                        }
                       self?.popViewController()
                        
                    case .failure(let error):
                        self?.showToastOnTop(message: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func callGetUserSettingAPI() {
        add(loadingViewController)
        router.serviceForEndPoint(apiType: .getUserAppSetting(model : [Constants.APIParameterKey.userID:LoginDetails.getUser()!.userID]), decodingType: UserSettingModel.self) {[weak self] (result) in
            DispatchQueue.main.async {
                self?.loadingViewController.remove()
                switch result {
                case .success(let responseData, let model):
                    guard let response = responseData  else {return}
                        if !response.success {
                            self?.showToastOnTop(message: response.message ?? "")
                        }
                    
                    if let settingModel = model {
                        self?.updateUI(settingModel: settingModel)
                    }
                    
                case .failure(let error):
                    self?.showToastOnTop(message: error.localizedDescription)
                }
            }
        }
    }
    

    
    func updateUI(settingModel : UserSettingModel) {
        self.companyWebsiteTextField.text = settingModel.webURL
        self.pageURLTextField.text = settingModel.landingURL
        self.kitURLTextField.text = settingModel.testKitURL
        updateButtonStatus(button: allButton, status: settingModel.ntfcAll)
        updateButtonStatus(button: failOnlyButton, status: settingModel.ntfcFailOnly)
        updateButtonStatus(button: passOnlyButton, status: settingModel.ntfcPassOnly)
        updateButtonStatus(button: noneButton, status: settingModel.ntfcNone)
        if let base64String = settingModel.imageBase64 , let image = base64String.base64ToImage() {
            photoImageView.image = image
            //photoEditIconImageView.isHidden = false
        }
    }
    
    func updateButtonStatus(button : UIButton, status : Bool?) {
        if let isTurnOn = status, isTurnOn == true {
            button.isSelected = isTurnOn
            configureHighlightedButton(button: button)
        } else {
            button.isSelected = false
            configureUnHighlightedButton(button: button)
        }
    }
    
}
