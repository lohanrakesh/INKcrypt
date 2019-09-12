//
//  PhoneNumberTableViewCell.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 2/26/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation
import SkyFloatingLabelTextField

let KPhoneNumberTableViewCellNibName = "PhoneNumberTableViewCell"
let KPhoneNumberTag = 101
let KContryCodeTag = 100

let KCompanyPhoneNumberTag = 102
let KCompanyContryCodeTag = 103



class PhoneNumberTableViewCell : UITableViewCell, UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var codeTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var phoneNumberTextField: SkyFloatingLabelTextField!
    var indexPath : IndexPath = IndexPath()
    weak var delegate : UpdatedProfileInfoDelegate?
    var pickerView = UIPickerView()
    var countryCodeArray = [CountryCode]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configurePhoneNumberTableViewCell(model : Profile?, indexPath : IndexPath,countryArray : [CountryCode]) {
        countryCodeArray = countryArray
        self.indexPath = indexPath
        switch indexPath.section {
        case 0:
            codeTextField.text = model?.userCountryCode
            codeTextField.tag = KContryCodeTag
            phoneNumberTextField.tag = KPhoneNumberTag
            phoneNumberTextField.text = model?.userMobileNo
        case 1 :
            codeTextField.text = model?.companyCountryCode
            codeTextField.tag = KCompanyContryCodeTag
            phoneNumberTextField.tag = KCompanyPhoneNumberTag
            phoneNumberTextField.text = model?.companyPhoneNo
        default:
            break
        }
        codeTextField.inputView = pickerView
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    //MARK:- Picker Delegate
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return self.countryCodeArray.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.countryCodeArray[row].text
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if !countryCodeArray.isEmpty {
            switch  self.indexPath.section {
            case 0:
                self.codeTextField.text = self.countryCodeArray[row].text
                delegate?.updatedInfoForIndexPath(indexPath: indexPath, info: self.codeTextField.text ?? "",tagValue : KContryCodeTag)

            case 1 :
                self.codeTextField.text = self.countryCodeArray[row].text
                delegate?.updatedInfoForIndexPath(indexPath: indexPath, info: self.codeTextField.text ?? "",tagValue : KCompanyContryCodeTag)
            default:
                break
            }
        }
        // pickerView.isHidden = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.updatedInfoForIndexPath(indexPath: indexPath, info: textField.text ?? "",tagValue : textField.tag)
    }
}
