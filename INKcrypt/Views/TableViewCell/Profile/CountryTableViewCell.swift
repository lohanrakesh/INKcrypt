//
//  CountryTableViewCell.swift
//  INKcrypt
//
//  Created by Asif on 19/04/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

let KCountryTableViewCellNibName = "CountryTableViewCell"

protocol fetchCoutryAndStateListDelegate: class {
    func fetchCountryListAPI()
    func fetchStateListAPI(selectedCountryID:String)
    func clearAllFieldRelatedToCountry()
}

class CountryTableViewCell: UITableViewCell,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    @IBOutlet weak var countryTextField: SkyFloatingLabelTextField!
    var indexPath : IndexPath = IndexPath()
    weak var delegate : UpdatedProfileInfoDelegate?
    var countryPickerView = UIPickerView()
    var countryArray : [Country]?
    weak var countryListDelegate : fetchCoutryAndStateListDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.countryPickerView.delegate = self
        self.countryPickerView.dataSource = self
        countryPickerView.tag = AddressPickerType.country.rawValue
        self.countryTextField.inputView = self.countryPickerView
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCountryTableViewCell(profileModel: Profile?, indexPath : IndexPath,arrayOfCountry:[Country]) {
        countryArray = arrayOfCountry
        self.indexPath = indexPath
        countryTextField.text = profileModel?.companycountryName
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.updatedInfoForIndexPath(indexPath: indexPath, info: textField.text ?? "",tagValue : 0)
    }
    
    //MARK:- UIPickerDelegate
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryArray?.count ?? 0
       
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countryArray?[row].text ?? ""
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let model = countryArray?[row] {
            self.countryTextField.text = model.text
            countryListDelegate?.clearAllFieldRelatedToCountry()
            countryListDelegate?.fetchStateListAPI(selectedCountryID: model.value ?? "")
        }
        
        
    }
    
    //MARK:- UITextFieldDelegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.countryTextField {
            if (countryArray?.isEmpty)! {
                countryListDelegate?.fetchCountryListAPI()
            }
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let textFieldString = textField.text, let swtRange = Range(range, in: textFieldString) {
                let fullString = textFieldString.replacingCharacters(in: swtRange, with: string)
                if fullString.isEmpty {
                    countryListDelegate?.clearAllFieldRelatedToCountry()
                }
            }
            return true
    }
        
}
