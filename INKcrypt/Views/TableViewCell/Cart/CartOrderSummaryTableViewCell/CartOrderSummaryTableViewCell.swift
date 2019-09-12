//
//  CartOrderSummaryTableViewCell.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 3/1/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

class CartOrderSummaryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemSubtotalLabel: UILabel!
    @IBOutlet weak var shippingLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var itemSubtotalCostLabel: UILabel!
    @IBOutlet weak var shippingCostLabel: UILabel!
    @IBOutlet weak var taxCostLabel: UILabel!
    @IBOutlet weak var totalCostLabel: UILabel!
    
    func configureCartOrderSummaryTableViewCell(model: CartDetail?) {
        if let subTotal = model?.cartDetailData?.cartSubTotal {
            self.itemSubtotalCostLabel.text = "$ \(subTotal)"
        }
        if let shippingCharge = model?.cartDetailData?.shippingCharges{
            self.shippingCostLabel.text = "$ \(shippingCharge)"
        }
        if let tax = model?.cartDetailData?.tax{
            self.taxCostLabel.text = "$ \(tax)"
        }
        if let cartTotal = model?.cartDetailData?.cartTotal{
            self.totalCostLabel.text = "$ \(cartTotal)"
        }
    }
    
    
}
