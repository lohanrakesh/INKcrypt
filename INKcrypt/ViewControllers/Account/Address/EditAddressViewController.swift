//
//  EditAddressViewController.swift
//  INKcrypt
//
//  Created by Asif on 27/02/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

enum AddressPickerType : Int {
    case country = 1
    case state = 2
}

typealias AddressCompletionHandler = ((_ addressInfo:AddressInfoModel,_ addressMode : AddressMode)->Void)

class EditAddressViewController: ViewController,UITextFieldDelegate {
    @IBOutlet weak var addressOneTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var addressTwoTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var countyTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var cityTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var stateTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var defaultAddressButton: UIButton!
    @IBOutlet weak var zipCodeTextField: SkyFloatingLabelTextField!
    var countryPickerView = UIPickerView()
    var statePickerView = UIPickerView()
    var isTextFieldCahnged = Bool()
    
    var addressCompletionHandler : AddressCompletionHandler = {_,_  in }
    var addressMode : AddressMode = AddressMode.add
    var addressInfo : AddressInfoModel?
    var addressType  = AddressType.defaultAddress
    var countryArray : [Country] = [] {
        didSet {
        }
    }
    var stateArray : [Country] = []
    var selectedCountryID : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setNavBarTitle()
        updateUI()
        callGetCountryListAPI()
        callGetStateListAPI(countryID: 1)
        // Do any additional setup after loading the view.
    }
    
    override func actionBackNavigationItem() {
        if isTextFieldCahnged {
            let alertController = UIAlertController(title: "Alert",
                                                    message: "Are you sure you want to discard all the changes?",
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK",
                                         style: .default) { _ in
                                            alertController.dismiss(animated: true, completion: nil)
                                            self.view.endEditing(true)
                                            self.navigationController?.popViewController(animated: true)
            }
            let cancelAction = UIAlertAction(title: "Cancel",
                                             style: .default) { _ in
                                                alertController.dismiss(animated: true, completion: nil)
                                                
            }
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            self.view.endEditing(true)
            self.navigationController?.popViewController(animated: true)
        }
      
    }
    
    // MARK: - Custom Method
    private func setNavBarTitle() {
        if addressMode == .add {
            self.title = PageTitleStrings.addAddress.localized
        } else {
            self.title = PageTitleStrings.updateAddress.localized
        }
    }
    
    public func updatedAddressInfo(addressInfo : AddressInfoModel?, addressMode : AddressMode, addressType : AddressType ,completionerHandler : @escaping AddressCompletionHandler) {
        self.addressInfo = addressInfo
        self.addressMode = addressMode
        self.addressType = addressType
        self.addressCompletionHandler = completionerHandler
    }
    
    private func checkValidation() -> Bool {
        if addressOneTextField.text?.isEmpty ?? true {
            self.present(UIAlertController(title: "Alert", message: "Please enter Address Line 1", defaultActionButtonTitle: "OK", tintColor: .blue), animated: true)
            return false
        }
        if addressTwoTextField.text?.isEmpty ?? true {
            self.present(UIAlertController(title: "Alert", message: "Please enter Address Line 2", defaultActionButtonTitle: "OK", tintColor: .blue), animated: true)
            return false
        }
        if countyTextField.text?.isEmpty ?? true {
            self.present(UIAlertController(title: "Alert", message: "Please enter Country", defaultActionButtonTitle: "OK", tintColor: .blue), animated: true)
            return false
        }
        if cityTextField.text?.isEmpty ?? true {
            self.present(UIAlertController(title: "Alert", message: "Please enter City", defaultActionButtonTitle: "OK", tintColor: .blue), animated: true)
            return false
        }
        if stateTextField.text?.isEmpty ?? true {
            self.present(UIAlertController(title: "Alert", message: "Please enter State", defaultActionButtonTitle: "OK", tintColor: .blue), animated: true)
            return false
        }
        if zipCodeTextField.text?.isEmpty ?? true {
            self.present(UIAlertController(title: "Alert", message: "Please enter Zip Code", defaultActionButtonTitle: "OK", tintColor: .blue), animated: true)
            return false
        }
        return true
    }
    
    func updateUI() {
       
        if self.addressMode == .edit {
            cityTextField.text = addressInfo?.cityName
            stateTextField.text = addressInfo?.stateName
            countyTextField.text = addressInfo?.countryName
            addressOneTextField.text = addressInfo?.shipAddress1
            addressTwoTextField.text = addressInfo?.shipAddress2
            zipCodeTextField.text = addressInfo?.zipcode
            if self.addressType == .defaultAddress {
                configureHighlightedButton(button: self.defaultAddressButton)
                self.defaultAddressButton.isUserInteractionEnabled = false
            } else {
                configureUnHighlightedButton(button: self.defaultAddressButton)
                self.defaultAddressButton.isUserInteractionEnabled = true
            }
            
        } else {
            if self.addressType == .defaultAddress {
                configureHighlightedButton(button: self.defaultAddressButton)
                self.defaultAddressButton.isUserInteractionEnabled = false
            } else {
                configureUnHighlightedButton(button: self.defaultAddressButton)
                self.defaultAddressButton.isUserInteractionEnabled = true
            }
            self.stateTextField.isUserInteractionEnabled = false

        }
        countyTextField.delegate = self
        stateTextField.delegate = self
        zipCodeTextField.delegate = self
        
        self.countryPickerView.delegate = self
        self.countryPickerView.dataSource = self
        self.statePickerView.dataSource = self
        self.statePickerView.delegate = self
        countryPickerView.tag = AddressPickerType.country.rawValue
        statePickerView.tag = AddressPickerType.state.rawValue
        self.countyTextField.inputView = self.countryPickerView
        self.stateTextField.inputView = self.statePickerView
        
        //check when a UITextField changed
        addressOneTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        addressTwoTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        countyTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        cityTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        stateTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        zipCodeTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        isTextFieldCahnged = true
    }
    
    private func configureHighlightedButton(button : UIButton) {
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.setImage(UIImage(named:"selected_checkbox"), for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.clear.cgColor
        button.isSelected = true
        addressType = AddressType.defaultAddress
    }
    
    private func configureUnHighlightedButton(button : UIButton) {
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.backgroundColor = UIColor.clear
        button.setImage(UIImage(named:"unselected_checkbox"), for: .normal)
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 2
        button.isSelected = false
        addressType = AddressType.otherAddress
    }
    
    
    private  func performSlectionStateForButton(button : UIButton) {
        if button.isSelected {
            configureUnHighlightedButton(button: defaultAddressButton)
        } else {
            configureHighlightedButton(button: defaultAddressButton)
        }
        if button.isSelected {
            button.isSelected = false
        } else {
            button.isSelected = true
        }
    }
    
    // MARK: - IBAction Method
    @IBAction func saveButtonAction(_ sender: Any) {
        if checkValidation() {
            callSaveAddressAPI()
        }
    }
    
    @IBAction func defaultAddressButtonAction(_ sender: Any) {
        if self.defaultAddressButton.isUserInteractionEnabled {
            if let button = sender as? UIButton {
            performSlectionStateForButton(button: button)
             isTextFieldCahnged = true
            }
        }
    }
 
}
