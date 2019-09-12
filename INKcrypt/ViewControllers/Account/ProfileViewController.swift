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
    var companyInfo : [ProfileCompanyInfo] = [.name,.phoneNumber,.city,.zipCode]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let profileTableHeaderViewNibName = UINib(nibName: KProfileTableHeaderViewNibName, bundle: nil)
        self.tableView.register(profileTableHeaderViewNibName, forHeaderFooterViewReuseIdentifier: KProfileTableHeaderViewNibName)
        
        let cityTableViewCellNibName = UINib(nibName: KCityTableViewCellNibName, bundle: nil)
        self.tableView.register(cityTableViewCellNibName, forCellReuseIdentifier: KCityTableViewCellNibName)
        
        let phoneNumberTableViewCellNibName = UINib(nibName: KPhoneNumberTableViewCellNibName, bundle: nil)
        self.tableView.register(phoneNumberTableViewCellNibName, forCellReuseIdentifier: KPhoneNumberTableViewCellNibName)
        
        let profileTableViewCell = UINib(nibName: Constants.CellIdentifier.profileTableViewCell, bundle: nil)
        self.tableView.register(profileTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.profileTableViewCell)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
