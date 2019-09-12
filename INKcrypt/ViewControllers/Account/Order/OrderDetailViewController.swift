//
//  OrderDetailViewController.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 4/15/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation
class OrderDetailViewController : ViewController {
    @IBOutlet weak var tableView: UITableView!
    var orderListArray : OrderDetail?

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBarTitle()
        registerTableForCartCellReuseIdentifier()
    }
    
    private func setNavBarTitle() {
        self.title = PageTitleStrings.orderDetails.localized
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func registerTableForCartCellReuseIdentifier() {
        let orderTableViewCell = UINib(nibName: Constants.CellIdentifier.orderTableViewCell, bundle: nil)
        tableView.register(orderTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.orderTableViewCell)
        
        let orderHeaderViewNibName = UINib(nibName: KOrderHeaderViewNibName, bundle: nil)
        tableView.register(orderHeaderViewNibName, forHeaderFooterViewReuseIdentifier: KOrderHeaderViewNibName)
        
        let cartOrderSummaryTableViewCell = UINib(nibName: Constants.CellIdentifier.cartOrderSummaryTableViewCell, bundle: nil)
        tableView.register(cartOrderSummaryTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.cartOrderSummaryTableViewCell)
    }

}
