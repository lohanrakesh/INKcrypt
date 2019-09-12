//
//  ProfileTableViewCell.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 2/25/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation
import SkyFloatingLabelTextField

protocol UpdatedProfileInfoDelegate : class {
    func updatedInfoForIndexPath(indexPath : IndexPath, info : String, tagValue : Int)
}

class ProfileTableViewCell: UITableViewCell,UITextFieldDelegate {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var topLineView: UIView!
    @IBOutlet weak var bottomLineView: UIView!
    @IBOutlet weak var textField: SkyFloatingLabelTextField!
    var indexPath : IndexPath = IndexPath()
    weak var delegate : UpdatedProfileInfoDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureLine(indexPath : IndexPath) {
        if indexPath.section == 0 {
            topLineView.isHidden = true
            bottomLineView.isHidden = false
            if indexPath.row == ProfilePersonalInfo.phoneNumber.rawValue {
                bottomLineView.isHidden = true
            }
        } else {
            topLineView.isHidden = true
            bottomLineView.isHidden = false
            if indexPath.row == ProfileCompanyInfo.zipCode.rawValue {
                bottomLineView.isHidden = true
                topLineView.isHidden = true
            }
        }
    }
    
    func configurePersonalInformationCell(indexPath : IndexPath, personalInfo : ProfilePersonalInfo, profileModel : Profile?) {
        self.indexPath = indexPath
        configureLine(indexPath: indexPath)
        textField.placeholder = personalInfo.discription
        
        switch indexPath.row {
        case ProfilePersonalInfo.firstName.rawValue:
            textField.keyboardType = .default
            self.textField.text = profileModel?.fisrtName
            
        case ProfilePersonalInfo.lastName.rawValue:
            textField.keyboardType = .default
            self.textField.text = profileModel?.lastName
            
        case ProfilePersonalInfo.email.rawValue:
            textField.keyboardType = .emailAddress
            self.textField.text = profileModel?.eMail
            
        case ProfilePersonalInfo.phoneNumber.rawValue:
            textField.keyboardType = .numberPad
            self.textField.text = profileModel?.companyPhoneNo
            
            
        default:
            break
        }
    }
    
    func configureCompanyInformationCell(indexPath : IndexPath, companyInfo : ProfileCompanyInfo,profileModel : Profile?) {
        self.indexPath = indexPath
        configureLine(indexPath: indexPath)
        textField.placeholder = companyInfo.discription
        switch indexPath.row {
        case ProfileCompanyInfo.name.rawValue:
            textField.keyboardType = .default
            self.textField.text = profileModel?.companyName
        case ProfileCompanyInfo.phoneNumber.rawValue:
            textField.keyboardType = .numberPad
            self.textField.text = profileModel?.companyPhoneNo
        case ProfileCompanyInfo.addressLine1.rawValue:
            textField.keyboardType = .default
            self.textField.text = profileModel?.address1
        case ProfileCompanyInfo.addressLine2.rawValue:
            textField.keyboardType = .default
            self.textField.text = profileModel?.address2
        case ProfileCompanyInfo.country.rawValue:
            textField.keyboardType = .default
            self.textField.text = profileModel?.companycountryName
        case ProfileCompanyInfo.zipCode.rawValue:
            textField.keyboardType = .numberPad
            self.textField.text = profileModel?.companyZipcode
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.updatedInfoForIndexPath(indexPath: indexPath, info: textField.text ?? "", tagValue : 0)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if indexPath.section == 1 && indexPath.row ==  ProfileCompanyInfo.zipCode.rawValue {
            let maxLength = 6 // Indian ZIP Code or PIN Code is a 6-digit number.
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        } else  {
            return true
        }
    }
    
}



