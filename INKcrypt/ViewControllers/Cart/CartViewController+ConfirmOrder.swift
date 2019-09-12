//
//  CartViewController+ConfirmOrder.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 3/7/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

extension CartViewController {
    func registerTableForConfirmOrderCellReuseIdentifier() {
        let cartAddressTableViewCell = UINib(nibName: Constants.CellIdentifier.cartAddressTableViewCell, bundle: nil)
        self.tableView.register(cartAddressTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.cartAddressTableViewCell)
        
        let paymentTableViewCell = UINib(nibName: Constants.CellIdentifier.paymentTableViewCell, bundle: nil)
        self.tableView.register(paymentTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.paymentTableViewCell)
    }
    
    func configureCellForConfirmOrder(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let count = self.cartDetail?.cartProductListData.count {
            if indexPath.row < count {
                return configureCartProductTableViewCell(tableView, cellForRowAt: indexPath)
            } else {
                if indexPath.row == count ||  indexPath.row == count + 1 {
                    return configureCartAddressTableViewCell(tableView, cellForRowAt: indexPath)
                } else if  indexPath.row == count + 2 {
                    return configurePaymentTableViewCell(tableView, cellForRowAt: indexPath)
                } else {
                    return configureCartOrderSummaryTableViewCell(tableView, cellForRowAt: indexPath)
                }
            }
        }
        return UITableViewCell()
    }
    
    func configureCartAddressTableViewCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cartAddressTableViewCell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.cartAddressTableViewCell) as? CartAddressTableViewCell else {return UITableViewCell() }
        cartAddressTableViewCell.selectionStyle = .none
        return cartAddressTableViewCell
    }
    
    func configurePaymentTableViewCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let paymentTableViewCell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.paymentTableViewCell) as? PaymentTableViewCell else {return UITableViewCell() }
        paymentTableViewCell.selectionStyle = .none
        return paymentTableViewCell
    }
}
