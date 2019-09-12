//
//  RegisterDetailViewController.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 26/03/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit

class RegisterDetailViewController: ViewController {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initializeView()
    }
    
    // MARK: - Custom Method
    func initializeView() {
        self.title = PageTitleStrings.register.localized
        
        self.tableView.estimatedRowHeight = 200.0
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.tableFooterView = UIView()
        
        let qrProductTableViewCell = UINib(nibName: Constants.CellIdentifier.qrCodeTableViewCell, bundle: nil)
        self.tableView.register(qrProductTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.qrCodeTableViewCell)
        
        let registerDetailTextFieldTableViewCell = UINib(nibName: Constants.CellIdentifier.registerDetailTextFieldTableViewCell, bundle: nil)
        self.tableView.register(registerDetailTextFieldTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.registerDetailTextFieldTableViewCell)
        
        let registerDetailCodeTableViewCell = UINib(nibName: Constants.CellIdentifier.registerDetailCodeTableViewCell, bundle: nil)
        self.tableView.register(registerDetailCodeTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.registerDetailCodeTableViewCell)
        
        let registerDetailSubordinateCodeTableViewCell = UINib(nibName: Constants.CellIdentifier.registerDetailSubordinateTableViewCell, bundle: nil)
        self.tableView.register(registerDetailSubordinateCodeTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.registerDetailSubordinateTableViewCell)
        
        let registerDetailBatchCertTableViewCell = UINib(nibName: Constants.CellIdentifier.registerDetailBatchCertTableViewCell, bundle: nil)
        self.tableView.register(registerDetailBatchCertTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.registerDetailBatchCertTableViewCell)
        
        let registerUploadImageTableViewCell = UINib(nibName: Constants.CellIdentifier.registerUploadImageTableViewCell, bundle: nil)
        self.tableView.register(registerUploadImageTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.registerUploadImageTableViewCell)
        
    }

}

//TODO: registerUploadImageTableViewCell
