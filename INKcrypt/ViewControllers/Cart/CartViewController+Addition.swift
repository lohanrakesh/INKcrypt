//
//  CartViewController+Addition.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 3/7/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

extension CartViewController {
    
    func updateUI() {
        guard self.cartDetail?.cartDetailData != nil else {
            self.tableView.isHidden = true
            noDataInfoLabel.isHidden = false
            actionButtonView.isHidden = true
            return
        }
        noDataInfoLabel.isHidden = true
        tableView.isHidden = false
        actionButtonView.isHidden = false
        self.tableView.reloadData()
    }

    func numberOfSections() -> Int {
        switch cartType.rawValue {
            
        case CartType.cart.rawValue:
            return 1
            
        case CartType.checkOut.rawValue:
            return 4
            
        case CartType.confirmOrder.rawValue:
            return 1
            
        default:
            return 0
        }
    }
    
    func numberOfRowsInSection( section: Int) -> Int {
        switch cartType.rawValue {
            
        case CartType.cart.rawValue:
             if let count = self.cartDetail?.cartProductListData.count {
                return count + 1
            }
            return 3
            
        case CartType.checkOut.rawValue:
            if section == 3 {
                return 2
            } else {
                return 1
            }
            
        case CartType.confirmOrder.rawValue:
            return numberOfRowsForConfirmOrder(section:section)
            
        default:
            return 0
        }
    }
    
    func numberOfRowsForConfirmOrder(section: Int) -> Int {
        if let count = cartDetail?.cartProductListData.count {
            return count + 4
        } else {
            return 0
        }
    }
    
    func viewForHeaderInSection(section: Int) -> UIView? {
        switch cartType.rawValue {
            
        case CartType.cart.rawValue:
            return configureHeaderView(displayInfo: "YOUR ORDER")
            
        case CartType.checkOut.rawValue:
            return configureHeaderViewForCheckOut(section:section)
            
        case CartType.confirmOrder.rawValue:
            return configureHeaderView(displayInfo: "YOUR ORDER")
            
        default:
            return nil
        }
    }
    
    func configureTitleAndReuseIdentifier() {
        registerTableForCartCellReuseIdentifier()
        
        switch cartType.rawValue {
        case CartType.confirmOrder.rawValue:
            registerTableForConfirmOrderCellReuseIdentifier()
            title = "Confirm Order"
            actionButton.setTitle("Place Order", for: .normal)
            
        case CartType.cart.rawValue:
            title = "Cart"
            actionButton.setTitle("Proceed to Checkout", for: .normal)
            
        case CartType.checkOut.rawValue:
            title = "Checkout"
            actionButton.setTitle("Continue", for: .normal)
            registerTableForCheckOutCellReuseIdentifier()
        default:
            break
        }
    }
    
    func registerTableForCartCellReuseIdentifier() {
        let cartProductTableViewCell = UINib(nibName: Constants.CellIdentifier.cartProductTableViewCell, bundle: nil)
        tableView.register(cartProductTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.cartProductTableViewCell)
        
        let cartOrderSummaryTableViewCell = UINib(nibName: Constants.CellIdentifier.cartOrderSummaryTableViewCell, bundle: nil)
        tableView.register(cartOrderSummaryTableViewCell, forCellReuseIdentifier: Constants.CellIdentifier.cartOrderSummaryTableViewCell)
        
        let profileTableHeaderViewNibName = UINib(nibName: KProfileTableHeaderViewNibName, bundle: nil)
        tableView.register(profileTableHeaderViewNibName, forHeaderFooterViewReuseIdentifier: KProfileTableHeaderViewNibName)
    }
    
    
    func configureHeaderViewForCheckOut(section : Int) -> UIView? {
        if let displayString = CheckoutSection(rawValue: section)?.discription {
            return configureHeaderView(displayInfo: displayString)
        } else{
            return nil
        }
    }
    func configureHeaderView(displayInfo : String) -> UIView {
        guard let profileHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: KProfileTableHeaderViewNibName) as? ProfileHeaderView else {return UIView() }
        profileHeaderView.configureSectionHeader(text: displayInfo)
        return profileHeaderView
    }
}
