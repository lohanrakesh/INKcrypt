//
//  NotificationVC+TableViewDelegate.swift
//  INKcrypt
//
//  Created by Asif on 18/04/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

extension NotificationViewController:UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int  {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfNotifications.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.notificationTableViewCell) as? NotificationTableViewCell
            else {return UITableViewCell() }
        cell.configureNotificationCell(model: arrayOfNotifications[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
