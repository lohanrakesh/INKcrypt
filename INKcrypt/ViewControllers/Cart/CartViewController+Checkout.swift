//
//  CartViewController+Checkout.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 3/7/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

extension CartViewController {
    
    func registerTableForCheckOutCellReuseIdentifier() {
        
        let editAddressTableViewCell = UINib(nibName: Constants.CellIdentifier.editAddressTableViewCell, bundle: nil)
        self.tableView.register(editAddressTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.editAddressTableViewCell)
        
        let deliveryTypeTableViewCell = UINib(nibName: Constants.CellIdentifier.deliveryTypeTableViewCell, bundle: nil)
        self.tableView.register(deliveryTypeTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.deliveryTypeTableViewCell)
        
        let editPaymentTableViewCell = UINib(nibName: Constants.CellIdentifier.editPaymentTableViewCell, bundle: nil)
        self.tableView.register(editPaymentTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.editPaymentTableViewCell)
        
    }
    
    func configureCellForCheckOut(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            return configureEditAddressTableViewCell(tableView, cellForRowAt: indexPath)
        case 1:
            return configureEditAddressTableViewCell(tableView, cellForRowAt: indexPath)
        case 2:
            return configureDeliveryTypeTableViewCell(tableView, cellForRowAt: indexPath)
        case 3:
            if indexPath.row == 0 {
                return configureEditPaymentTableViewCell(tableView, cellForRowAt: indexPath)
            } else {
                return configureCartOrderSummaryTableViewCell(tableView, cellForRowAt: indexPath)
            }
            
        default:
            return UITableViewCell()
        }
    }
    
    func configureEditAddressTableViewCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.editAddressTableViewCell) as? EditAddressTableViewCell else {return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.configureEditAddressCell()
        return cell
    }
    
    func configureDeliveryTypeTableViewCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.deliveryTypeTableViewCell) as? DeliveryTypeTableViewCell else {return UITableViewCell() }
        cell.selectionStyle = .none
        cell.configureDeliveryTypeCell()
        return cell
    }
    
    func configureEditPaymentTableViewCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.editPaymentTableViewCell) as? EditPaymentTableViewCell else {return UITableViewCell() }
        cell.selectionStyle = .none
        return cell
    }
    
    
    
    
}
