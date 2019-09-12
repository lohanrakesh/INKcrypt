//
//  CityTableViewCell.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 2/26/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation
import SkyFloatingLabelTextField

let KCityTableViewCellNibName = "CityTableViewCell"
let KCitiTag = 1
let KStateTag = 2

protocol ProfileCityAndStateCellDelegate : class {
    func notifyThisWhenStateTextFieldStartEditing()
}

class CityTableViewCell : UITableViewCell,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    @IBOutlet weak var cityTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var stateTextField: SkyFloatingLabelTextField!
    var indexPath : IndexPath = IndexPath()
    weak var delegate : UpdatedProfileInfoDelegate?
    var statePickerView = UIPickerView()
    var stateArray : [Country]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.statePickerView.dataSource = self
        self.statePickerView.delegate = self
        self.stateTextField.inputView = self.statePickerView
        statePickerView.tag = AddressPickerType.state.rawValue

    }

    func configureCityTableViewCell(profileModel: Profile?, indexPath : IndexPath,arrayOfStates:[Country]) {
        self.stateArray = arrayOfStates
        self.indexPath = indexPath
        cityTextField.text = profileModel?.companyCityName
        stateTextField.text = profileModel?.companystateName
        cityTextField.tag = KCitiTag
        stateTextField.tag = KStateTag
        if let cName = profileModel?.companycountryName , cName.isEmpty {
            stateTextField.isUserInteractionEnabled = false
        } else {
              stateTextField.isUserInteractionEnabled = true
        }
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.updatedInfoForIndexPath(indexPath: indexPath, info: textField.text ?? "",tagValue : textField.tag)
    }
   
    //MARK:- UIPickerDelegate
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stateArray?.count ?? 0
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stateArray?[row].text ?? ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let count = stateArray?.count , count > 0 , let str = stateArray?[row].text {
                self.stateTextField.text = str
            }
    }
    
}
