//
//  PatternDetailViewController.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 21/02/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit

class PatternDetailViewController: ViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.initializeView()
    }
    
    // MARK: - Custom Method
    func initializeView() {
        self.tableView.layer.cornerRadius = 5.0
        
        self.tableView.estimatedRowHeight = 180.0
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.registerCell()
    }
    
    func registerCell(){
        let qrCodeTableViewCell = UINib(nibName: Constants.CellIdentifier.qrCodeTableViewCell, bundle: nil)
        self.tableView.register(qrCodeTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.qrCodeTableViewCell)
        
        let patternDetailTableViewCell = UINib(nibName: Constants.CellIdentifier.patternDetailTableViewCell, bundle: nil)
        self.tableView.register(patternDetailTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.patternDetailTableViewCell)
        
        let patternImageTableViewCell = UINib(nibName: Constants.CellIdentifier.patternImageTableViewCell, bundle: nil)
        self.tableView.register(patternImageTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.patternImageTableViewCell)
        
    }
    
    // MARK: - Action

}
