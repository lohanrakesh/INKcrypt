//
//  NotificationViewController.swift
//  INKcrypt
//
//  Created by Asif on 18/04/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit

struct NotificationModel {
    let title : String?
    let subTitle : String?
    let time : String?
}

class NotificationViewController: ViewController {
    @IBOutlet weak var tableView: UITableView!
    var arrayOfNotifications = [NotificationModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
        registerTableCell()
        showNotificationsFromModel()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Custom Method
    private func initializeView() {
        self.title = PageTitleStrings.notification.localized
    }
    private func registerTableCell() {
        tableView.tableFooterView = UIView()
        let notificationTableViewCell = UINib(nibName: Constants.CellIdentifier.notificationTableViewCell, bundle: nil)
        tableView.register(notificationTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.notificationTableViewCell)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
    }
    private func showNotificationsFromModel()  {
        arrayOfNotifications = [
            NotificationModel(title: "Order Confimed", subTitle: "Your Order Spray Bottle 10 ML is confirmed.", time: "2 MIN AGO"),
            NotificationModel(title: "Order Delivered", subTitle: "Your Order is successfully delivered.", time: "10 MIN AGO")
        ]
        tableView.reloadData()
    }
    
    @IBAction func cancelButtonAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
