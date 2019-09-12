//
//  ContactSupportViewController.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 14/03/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit

class ContactSupportViewController: ViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.initializeView()
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let currentViewController = segue.destination as? ContactSupportTableViewController, segue.identifier == Constants.SegueIdentifier.contactSupport {
//            self.embeddedViewController = currentViewController
//        }
//    }
    
    // MARK: - Custom Method
    
    func initializeView() {
        // Add Targets
        
        self.tableView.estimatedRowHeight = 300.0
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.registerCell()
        
        if let user = LoginDetails.getUser() {
            self.nameTextField.text = user.userName
            self.companyTextField.text = user.companyName
            self.phoneTextField.text = user.userMobileNo
            self.emailTextField.text = user.email
        }
    }
    
    func registerCell(){
        let contactUsCheckBoxTableViewCell = UINib(nibName: Constants.CellIdentifier.contactUsCheckBoxTableViewCell, bundle: nil)
        self.tableView.register(contactUsCheckBoxTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.contactUsCheckBoxTableViewCell)
        
        let contactUsDetailTableViewCell = UINib(nibName: Constants.CellIdentifier.contactUsDetailTableViewCell, bundle: nil)
        self.tableView.register(contactUsDetailTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.contactUsDetailTableViewCell)
        
    }
    
    func contactSupportApiCall(){
        add(loadingViewController)
        
        guard
            let name = nameTextField.text,
            let company = companyTextField.text,
            let phone = phoneTextField.text,
            let email = emailTextField.text,
            let description = descriptionTextView.text, let user = LoginDetails.getUser()
            else {
                return
        }
        router.serviceForEndPoint(apiType: .contactUs(name: name, email: email, company: company, phoneNumber: phone, description: description, userId: "\(user.userID)"), decodingType: ForgotPassword.self) {[weak self] (result) in
            DispatchQueue.main.async {
                self?.loadingViewController.remove()
            }
            switch result {
            case .success(let responseData, let model):
                guard let response = responseData else {return}
                if  response.success {
                    if model != nil {
                        DispatchQueue.main.async {
                        self?.popViewController()
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
    }
    
    /**
     submitButton Action
     */
    @IBAction func submitButtonClicked(sender: Any) {
        debugPrint("submit Button clicked")
        self.view.endEditing(true)
        self.submitButton.isEnabled = false
        guard
            let name = nameTextField.text, !name.isEmpty,
            let company = companyTextField.text, !company.isEmpty,
            let phone = phoneTextField.text, !phone.isEmpty, Utility.isValidPhoneNumber(value: phone),
            let email = emailTextField.text, !email.isEmpty, Utility.isValidEmail(testStr: email),
            let description = descriptionTextView.text, !description.isEmpty
            else {
                self.submitButton.isEnabled = true

                if (self.nameTextField.text?.isEmpty)! {
                    self.showToastOnTop(message: AlertMessages.enterName.localized)
                } else if (self.companyTextField.text?.isEmpty)! {
                    self.showToastOnTop(message: AlertMessages.enterCompany.localized)
                }else if (self.phoneTextField.text?.isEmpty)! {
                    self.showToastOnTop(message: AlertMessages.enterMobileNumber.localized)
                } else if !(Utility.isValidPhoneNumber(value: self.phoneTextField.text!)) {
                    self.showToastOnTop(message: AlertMessages.validMobileNumber.localized)
                }else if (self.emailTextField.text?.isEmpty)! {
                    self.showToastOnTop(message: AlertMessages.enterMail.localized)
                } else if !(Utility.isValidEmail(testStr: self.emailTextField.text!)) {
                    self.showToastOnTop(message: AlertMessages.validMail.localized)
                }else if (self.descriptionTextView.text?.isEmpty)! {
                    self.showToastOnTop(message: AlertMessages.enterDescription.localized)
                }
                return
        }
        self.submitButton.isEnabled = true

        self.contactSupportApiCall()
    }
}

extension ContactSupportViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int  {
        return 4
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
            
        case 0, 1:
            return 8
            
        case 2:
            return 2
            
        case 3:
            return 4
            
        default:
            return 1
        }
    }
//
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = Bundle.main.loadNibNamed(String(describing: ContactUsTableCellSection.self), owner: nil, options: nil)![0] as? ContactUsTableCellSection else {
            return nil
        }

        return header
    }
    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        var footer = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 6.0))
//        footer.backgroundColor = UIColor.init(red: 243.0/255.0, green: 243.0/255.0, blue: 243.0/255.0, alpha: 1.0)
//
//        return footer
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 42.0
    }
//
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 0.0
//    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let model = self.productArray[indexPath.section]
//
        switch indexPath.section {

        case 0, 1, 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.contactUsCheckBoxTableViewCell) as? ContactUsCheckBoxTableViewCell
                else {return UITableViewCell() }
        
            cell.selectionStyle = .none
            return cell

        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.contactUsDetailTableViewCell) as? ContactUsDetailTableViewCell
                else {return UITableViewCell() }
            cell.selectionStyle = .none

            return cell

        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
