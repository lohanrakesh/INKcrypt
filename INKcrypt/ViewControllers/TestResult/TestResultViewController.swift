//
//  TestResultViewController.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 22/02/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit

class TestResultViewController: ViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    var testType: TestType = .success
    
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.initializeView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - Custom Method
    func initializeView() {
        self.title = PageTitleStrings.test.localized
        
        self.tableView.estimatedRowHeight = 180.0
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.registerCell()
    }
    
    func registerCell(){
        let qrCodeTableViewCell = UINib(nibName: Constants.CellIdentifier.qrCodeTableViewCell, bundle: nil)
        self.tableView.register(qrCodeTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.qrCodeTableViewCell)
        
        let testSuccessTableViewCell = UINib(nibName: Constants.CellIdentifier.testSuccessTableViewCell, bundle: nil)
        self.tableView.register(testSuccessTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.testSuccessTableViewCell)
        
        let qrProductTableViewCell = UINib(nibName: Constants.CellIdentifier.qrProductTableViewCell, bundle: nil)
        self.tableView.register(qrProductTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.qrProductTableViewCell)
        
        let testItemReferenceTableViewCell = UINib(nibName: Constants.CellIdentifier.testItemReferenceTableViewCell, bundle: nil)
        self.tableView.register(testItemReferenceTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.testItemReferenceTableViewCell)
        
        let testFailTableViewCell = UINib(nibName: Constants.CellIdentifier.testFailTableViewCell, bundle: nil)
        self.tableView.register(testFailTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.testFailTableViewCell)
        
        let testFailReferenceTableViewCell = UINib(nibName: Constants.CellIdentifier.testFailReferenceTableViewCell, bundle: nil)
        self.tableView.register(testFailReferenceTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.testFailReferenceTableViewCell)
        
        
    }
    
    // MARK: - Action
    @IBAction func retryButtonClicked(sender: UIButton){
        
    }
    
    @IBAction func doneButtonClicked(sender: UIButton){
        guard let contactOwnerViewController = UIStoryboard.authenticateStoryboard().instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.contactOwnerViewController) as? ContactOwnerViewController else {
            return
        }
       
        self.present(contactOwnerViewController, animated: true, completion: nil)
    }

}
