//
//  TabBarViewController.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 13/03/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
