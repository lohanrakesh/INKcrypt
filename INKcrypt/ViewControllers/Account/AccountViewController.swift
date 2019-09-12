//
//  AccountViewController.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 2/22/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

class AccountViewController : ViewController {
    @IBOutlet weak var tableView: UITableView!

    var dataSourceArray : [AccountInfo] = [.myProfile,.orderHistory,.address,.savedCard,.myBiomarkersCodes,.report,.settings,.about,.contactAndSupport,.termsAndConditions]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !isUserLogin() {
          dataSourceArray = [.about,.contactAndSupport,.termsAndConditions]
        }
        let headerViewNibName = UINib(nibName: KSignInHeaderViewNibName, bundle: nil)
        tableView.register(headerViewNibName, forHeaderFooterViewReuseIdentifier: KSignInHeaderViewNibName)
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    func signInAction() {
        kAppDelegate.window?.rootViewController = UIStoryboard.signInStoryboard().instantiateInitialViewController()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
