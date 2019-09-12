//
//  EditAddressViewController+WebService.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 3/28/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

extension EditAddressViewController:UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: - API Method
    func callSaveAddressAPI() {
        if let user = LoginDetails.getUser(), let shipAddress1 = addressOneTextField.text, let shipAddress2 = addressTwoTextField.text, let countryName = self.countyTextField.text, let stateName = stateTextField.text, let cityName = self.cityTextField.text, let zipcode = self.zipCodeTextField.text {
            var isDefaultAddress = false
            var dict : [String:Any] = [:]
            if addressType == .defaultAddress {
                isDefaultAddress = true
            }
            
            dict = [Constants.APIParameterKey.shipAddress1: shipAddress1,Constants.APIParameterKey.shipAddress2: shipAddress2,Constants.APIParameterKey.countryName:countryName,Constants.APIParameterKey.stateName:stateName,Constants.APIParameterKey.cityName:cityName,Constants.APIParameterKey.zipcode:zipcode,Constants.APIParameterKey.IsDefault:isDefaultAddress,Constants.APIParameterKey.UserId:user.userID]
            if self.addressMode == .edit {
                dict[Constants.APIParameterKey.addressId] = addressInfo?.addressID
            }
            add(loadingViewController)
            router.serviceForEndPoint(apiType: .saveAddress(model: dict), decodingType: AddressInfoModel.self) { [weak self] (result) in
                DispatchQueue.main.async {
                    self?.loadingViewController.remove()
                    switch result {
                    case .success(let responseData, let model):
                        if let response = responseData {
                            if response.success {
                                if let addressModel = model {
                                    self?.addressCompletionHandler(addressModel,self!.addressMode)
                                    self?.popViewController()
                                }
                            } else {
                                self?.showToastOnTop(message: response.message ?? "Save address API failed")
                            }
                        }
                        
                    case .failure(let error):
                        self?.showToastOnTop(message: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func callGetCountryListAPI() {
        if let user = LoginDetails.getUser() {
            router.serviceForEndPoint(apiType: .getCountryList(model: [Constants.APIParameterKey.userID:String(user.userID)]), decodingType: [Country].self) {[weak self] (result) in
                DispatchQueue.main.async {
                    self?.loadingViewController.remove()
                }
                switch result {
                case .success(let responseData, let model):
                    if let response = responseData {
                        if response.success {
                            if let countryArray = model {
                                self?.countryArray.removeAll()
                                self?.countryArray.append(contentsOf: countryArray)
                            }
                        } else {
                            self?.showToastOnTop(message: response.message ?? "Country API failed")
                        }
                    }
                    
                case .failure(let error):
                    self?.showToastOnTop(message: error.localizedDescription)
                }
            }
        }
    }
    
    func callGetStateListAPI(countryID : Int) {
        router.serviceForEndPoint(apiType: .getStateList(countryID: countryID), decodingType: [Country].self) {[weak self] (result) in
            DispatchQueue.main.async {
                self?.loadingViewController.remove()
            }
            switch result {
            case .success(let responseData, let model):
                if let response = responseData {
                    if response.success {
                        if let array = model {
                            self?.stateArray.removeAll()
                            self?.stateArray.append(contentsOf: array)
                        }
                    } else {
                        self?.showToastOnTop(message: response.message ?? "State API failed")
                    }
                }
                
            case .failure(let error):
                self?.showToastOnTop(message: error.localizedDescription)
            }
        }
    }
    
    func fetchStateList() {
        if let str = selectedCountryID, let identifier = Int(str) {
            callGetStateListAPI(countryID: identifier)
        }
    }
    
    //MARK:- UIPickerDelegate
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == AddressPickerType.country.rawValue {
            return countryArray.count
        } else {
            return stateArray.count
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == AddressPickerType.country.rawValue {
            return countryArray[row].text
        } else {
            return stateArray[row].text
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == AddressPickerType.country.rawValue {
            let model = countryArray[row]
            self.countyTextField.text = model.text
            // Clear all the related fields
            self.cityTextField.text = ""
            self.stateTextField.text = ""
            self.zipCodeTextField.text = ""
            self.stateTextField.isUserInteractionEnabled = true
            selectedCountryID = model.value
            fetchStateList()
            
        } else {
            if let str = stateArray[row].text , !((self.countyTextField.text?.isEmpty)!){
                self.stateTextField.text = str
            }
        }
    }
    
    //MARK:- UITextFieldDelegate
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        if textField == self.countyTextField {
            if countryArray.isEmpty {
                callGetCountryListAPI()
            }
        }
        if textField == self.stateTextField {
            if !stateArray.isEmpty {
                stateTextField.isHidden = false
            } else {
                fetchStateList()
            }
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.zipCodeTextField {
            let maxLength = 6 // Indian ZIP Code or PIN Code is a 6-digit number.
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        } else  if textField == self.countyTextField {
            if let textFieldString = textField.text, let swtRange = Range(range, in: textFieldString) {
                let fullString = textFieldString.replacingCharacters(in: swtRange, with: string)
                if fullString.isEmpty {
                    self.cityTextField.text = ""
                    self.stateTextField.text = ""
                    self.zipCodeTextField.text = ""
                    self.stateTextField.isUserInteractionEnabled = false
                } else {
                     self.stateTextField.isUserInteractionEnabled = true
                }
            }
            return true
            
        } else  {
            return true
        }
    }
}
