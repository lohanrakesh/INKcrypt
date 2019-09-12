//
//  OrderViewController.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 3/8/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation
class OrderViewController : ViewController {
    @IBOutlet weak var tableView: UITableView!
    var orderListArray : [OrderList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBarTitle()
        registerTableForCartCellReuseIdentifier()
    }
    
    private func setNavBarTitle() {
        self.title = PageTitleStrings.myOrder.localized
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.cherryRed]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        callOrderHistoryAPI()
    }
    
    func registerTableForCartCellReuseIdentifier() {
        let orderTableViewCell = UINib(nibName: Constants.CellIdentifier.orderTableViewCell, bundle: nil)
        tableView.register(orderTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.orderTableViewCell)
        
        let orderHeaderViewNibName = UINib(nibName: KOrderHeaderViewNibName, bundle: nil)
        tableView.register(orderHeaderViewNibName, forHeaderFooterViewReuseIdentifier: KOrderHeaderViewNibName)
    }
}

extension OrderViewController:UITableViewDataSource,UITableViewDelegate  {
    func numberOfSections(in tableView: UITableView) -> Int  {
        return 3//orderListArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3//orderListArray[section].orderHistoryListData.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: KOrderHeaderViewNibName) as? OrderHeaderView else {return UIView() }
//        if let orderID = orderListArray[section].orderID {
//            headerView.configureOrderHeaderViewWithInfo(orderID: String(orderID))
//        }
         return headerView
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.orderTableViewCell) as? OrderTableViewCell else {return UITableViewCell() }
        cell.selectionStyle = .none
       //  cell.configureOrderTableViewCell(model: orderListArray[indexPath.section].orderHistoryListData[indexPath.row], orderDetails: orderListArray[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
}


