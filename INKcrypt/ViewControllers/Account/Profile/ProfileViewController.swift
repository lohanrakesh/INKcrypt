//
//  ProfileViewController.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 2/25/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

class ProfileViewController : ViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var personalInfo : [ProfilePersonalInfo] = [.firstName,.lastName,.email,.phoneNumber]
    var companyInfo : [ProfileCompanyInfo] = [.name,.phoneNumber,.addressLine1,.addressLine2,.city,.country,.zipCode]
    var profileModel : Profile?
    var countryCodeArray = [CountryCode]()
    
    var updateModel : [String : Any] = [:] { didSet {
        debugPrint("UpdateModel \(updateModel)")
        }
    }
    var countryArray : [Country] = [] {
        didSet {
        }
    }
    var stateArray : [Country] = []
    var selectedCountryID : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableForCellReuseIdentifier()
        callMyProfileAPI()
        getCountryCodeApiCall()
        callGetCountryListAPI()
        callGetStateListAPI(countryID: 1)
        
        if let user = LoginDetails.getUser() {
            updateModel[Constants.APIParameterKey.userID] = String(user.userID)
        }
        self.title = PageTitleStrings.profile.localized
        
    }
    
    func registerTableForCellReuseIdentifier() {
        let profileTableHeaderViewNibName = UINib(nibName: KProfileTableHeaderViewNibName, bundle: nil)
        self.tableView.register(profileTableHeaderViewNibName, forHeaderFooterViewReuseIdentifier: KProfileTableHeaderViewNibName)
        
        let cityTableViewCellNibName = UINib(nibName: KCityTableViewCellNibName, bundle: nil)
        self.tableView.register(cityTableViewCellNibName, forCellReuseIdentifier: KCityTableViewCellNibName)
        
        let countryTableViewCellNibName = UINib(nibName: KCountryTableViewCellNibName, bundle: nil)
        self.tableView.register(countryTableViewCellNibName, forCellReuseIdentifier: KCountryTableViewCellNibName)

        let phoneNumberTableViewCellNibName = UINib(nibName: KPhoneNumberTableViewCellNibName, bundle: nil)
        self.tableView.register(phoneNumberTableViewCellNibName, forCellReuseIdentifier: KPhoneNumberTableViewCellNibName)
        
        let profileTableViewCell = UINib(nibName: Constants.CellIdentifier.profileTableViewCell, bundle: nil)
        self.tableView.register(profileTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.profileTableViewCell)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureUpdateModel() {
        guard let model = profileModel else{return}
        //Personal Info
        updateModel[Constants.APIParameterKey.companyInfoId] = model.companyInfoID
        updateModel[Constants.APIParameterKey.fisrtName] = model.fisrtName
        updateModel[Constants.APIParameterKey.lastName] = model.lastName
        updateModel[Constants.APIParameterKey.eMail] = model.eMail
        updateModel[Constants.APIParameterKey.userMobileNo] = model.userMobileNo
        updateModel[Constants.APIParameterKey.userCountryCode] = model.userCountryCode
        // Company Info
        updateModel[Constants.APIParameterKey.companyName] = model.companyName
        updateModel[Constants.APIParameterKey.companyCountryCode] = model.companyCountryCode
        updateModel[Constants.APIParameterKey.companyPhoneNo] = model.companyPhoneNo
        updateModel[Constants.APIParameterKey.address1] = model.address1
        updateModel[Constants.APIParameterKey.address2] = model.address2
        updateModel[Constants.APIParameterKey.companycountryName] = model.companycountryName
        updateModel[Constants.APIParameterKey.companyCityName] = model.companyCityName
        updateModel[Constants.APIParameterKey.companyStateName] = model.companystateName
        updateModel[Constants.APIParameterKey.companyZipcode] = model.companyZipcode
       
    }
    override func actionBackNavigationItem() {
            let alertController = UIAlertController(title: AlertMessages.alertTitle.localized,
                                                    message: "Are you sure you want to discard all the changes?",
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: AlertMessages.alertOk.localized,
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
    }
    
    func checkValidation() -> Bool {
        print(updateModel)
        guard let model = profileModel else {
            return false
        }
        if model.fisrtName?.isEmpty ?? true {
            //
            self.present(UIAlertController(title: AlertMessages.alertTitle.localized, message: AlertMessages.enterFirstName.localized, defaultActionButtonTitle: AlertMessages.alertOk.localized, tintColor: .blue), animated: true)
            return false
        }
        // Last name should be optional
//        if model.lastName?.isEmpty ?? true {
//            self.present(UIAlertController(title: AlertMessages.alertTitle.localized, message: "Please enter last Name", defaultActionButtonTitle: AlertMessages.alertOk.localized, tintColor: .blue), animated: true)
//            return false
//        }
        
        if model.eMail?.isEmpty ?? true {
            self.present(UIAlertController(title: AlertMessages.alertTitle.localized, message: AlertMessages.enterMail.localized, defaultActionButtonTitle: AlertMessages.alertOk.localized, tintColor: .blue), animated: true)
            return false
        }
        
        if model.userMobileNo?.isEmpty ?? true { self.present(UIAlertController(title: AlertMessages.alertTitle.localized, message: AlertMessages.enterMobileNumber.localized, defaultActionButtonTitle: AlertMessages.alertOk.localized, tintColor: .blue), animated: true)
            return false}
        
        if model.userMobileNo?.hasPrefix("0") ?? false {self.present(UIAlertController(title: AlertMessages.alertTitle.localized, message: AlertMessages.mobileZeroPrefix.localized, defaultActionButtonTitle: AlertMessages.alertOk.localized, tintColor: .blue), animated: true)
            return false }
        
        return true
        
        if model.userCountryCode?.isEmpty ?? true { self.present(UIAlertController(title: AlertMessages.alertTitle.localized, message: "Please enter user Country Code", defaultActionButtonTitle: AlertMessages.alertOk.localized, tintColor: .blue), animated: true)
            return false }
        
        return checkValidationForCompanyInfo(model : model)

    }
    
    func checkValidationForCompanyInfo(model : Profile) -> Bool {
        //
        if model.companyName?.isEmpty ?? true { self.present(UIAlertController(title: AlertMessages.alertTitle.localized, message: "Please enter company Name", defaultActionButtonTitle: AlertMessages.alertOk.localized, tintColor: .blue), animated: true)
            return false}
        
        if model.companyCountryCode?.isEmpty ?? true {self.present(UIAlertController(title: AlertMessages.alertTitle.localized, message: "Please enter company Country Code", defaultActionButtonTitle: AlertMessages.alertOk.localized, tintColor: .blue), animated: true)
            return false}
        
        if model.companyPhoneNo?.isEmpty ?? true { self.present(UIAlertController(title: AlertMessages.alertTitle.localized, message: "Please enter company phone number", defaultActionButtonTitle: AlertMessages.alertOk.localized, tintColor: .blue), animated: true)
            return false}
        
        if model.address1?.isEmpty ?? true { self.present(UIAlertController(title: AlertMessages.alertTitle.localized, message: "Please enter address line 1", defaultActionButtonTitle: AlertMessages.alertOk.localized, tintColor: .blue), animated: true)
            return false}
        
        if model.address2?.isEmpty ?? true { self.present(UIAlertController(title: AlertMessages.alertTitle.localized, message: "Please enter address line 2", defaultActionButtonTitle: AlertMessages.alertOk.localized, tintColor: .blue), animated: true)
            return false}
        
        if model.companycountryName?.isEmpty ?? true { self.present(UIAlertController(title: AlertMessages.alertTitle.localized, message: "Please enter company country name", defaultActionButtonTitle: AlertMessages.alertOk.localized, tintColor: .blue), animated: true)
            return false}
        
        if model.companyCityName?.isEmpty ?? true { self.present(UIAlertController(title: AlertMessages.alertTitle.localized, message: "Please enter company city name", defaultActionButtonTitle: AlertMessages.alertOk.localized, tintColor: .blue), animated: true)
            return false}
        
        if model.companystateName?.isEmpty ?? true { self.present(UIAlertController(title: AlertMessages.alertTitle.localized, message: "Please enter state", defaultActionButtonTitle: AlertMessages.alertOk.localized, tintColor: .blue), animated: true)
            return false}
        
        if model.companyZipcode?.isEmpty ?? true {self.present(UIAlertController(title: AlertMessages.alertTitle.localized, message: "Please enter company zip code", defaultActionButtonTitle: AlertMessages.alertOk.localized, tintColor: .blue), animated: true)
            return false}
        return true
    }
    
    
}

//func isValidPinCode(_ pincode: String?) -> Bool {
//    let pinRegex = "^[0-9]{6}$"
//    let pinTest = NSPredicate(format: "SELF MATCHES %@", pinRegex)
//
//    let pinValidates: Bool = pinTest.evaluate(with: pincode)
//    return pinValidates
//}
