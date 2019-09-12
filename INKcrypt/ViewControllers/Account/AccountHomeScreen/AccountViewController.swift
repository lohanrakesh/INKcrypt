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
    
    var dataSourceArray : [AccountInfo] = [.myProfile,.orderHistory,.address,.savedCard,.myBiomarkersCodes,.report,.settings,.changePassword,.about,.contactAndSupport,.termsAndConditions,.logout]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setNavBarTitle()
        let headerViewNibName = UINib(nibName: KSignInHeaderViewNibName, bundle: nil)
        tableView.register(headerViewNibName, forHeaderFooterViewReuseIdentifier: KSignInHeaderViewNibName)
        tableView.tableFooterView = UIView()
    }
    
    private func setNavBarTitle() {
        self.title = PageTitleStrings.account.localized
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadTableView()
    }
    
    func reloadTableView() {
        if !isUserLogin() {
            dataSourceArray = [.about,.contactAndSupport,.termsAndConditions]
        } else {
            dataSourceArray = [.myProfile,.orderHistory,.address,.savedCard,.myBiomarkersCodes,.report,.settings,.changePassword,.about,.contactAndSupport,.termsAndConditions,.logout]
        }
        self.tableView.reloadData()
    }
    
    func signInAction() {
        let signInViewController = UIStoryboard.signInStoryboard().instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.signInViewController)
        let nav = UINavigationController.init(rootViewController: signInViewController)
        self.present(nav, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
