//
//  CartViewController+TableView.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 3/1/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

extension CartViewController:UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int  {
        return numberOfSections()
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return viewForHeaderInSection(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cartType.rawValue {
        case CartType.cart.rawValue:
             return configureCellForCart(tableView, cellForRowAt: indexPath)
            
        case CartType.checkOut.rawValue:
            return configureCellForCheckOut(tableView, cellForRowAt: indexPath)
            
        case CartType.confirmOrder.rawValue:
            return configureCellForConfirmOrder(tableView, cellForRowAt: indexPath)
            
        default:
            return UITableViewCell()
        }
    }

    func configureCellForCart(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let count = self.cartDetail?.cartProductListData.count {
            if indexPath.row == count {
                return configureCartOrderSummaryTableViewCell(tableView, cellForRowAt: indexPath)
            }else {
               return configureCartProductTableViewCell(tableView, cellForRowAt: indexPath)
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    func configureCartProductTableViewCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cartProductTableViewCell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.cartProductTableViewCell) as? CartProductTableViewCell else {
            return UITableViewCell()
        }
        
        if cartType == .cart {
            cartProductTableViewCell.configureCartProductTableViewCell(hideDeleteButton: false, cartProduct: self.cartDetail?.cartProductListData[indexPath.row])
        } else {
         cartProductTableViewCell.configureCartProductTableViewCell(hideDeleteButton: true, cartProduct: self.cartDetail?.cartProductListData[indexPath.row])
        }
        
        cartProductTableViewCell.indexPath = indexPath
        cartProductTableViewCell.selectionStyle = .none
        return cartProductTableViewCell
    }
    
    func configureCartOrderSummaryTableViewCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cartOrderSummaryTableViewCell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.cartOrderSummaryTableViewCell) as? CartOrderSummaryTableViewCell else {
            return UITableViewCell()
        }
        cartOrderSummaryTableViewCell.configureCartOrderSummaryTableViewCell(model: self.cartDetail)
        cartOrderSummaryTableViewCell.selectionStyle = .none
        return cartOrderSummaryTableViewCell
    }

}
