//
//  OrderTableViewCell.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 3/8/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

class OrderTableViewCell : UITableViewCell {
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var bioMarkerNumberLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var orderPlaceOnLabel: UILabel!
    @IBOutlet weak var orderDeliverOnLabel: UILabel!
    
    func configureOrderTableViewCell(model : OrderHistoryListDatum, orderDetails : OrderList) {
        productNameLabel.text = model.productName
        bioMarkerNumberLabel.text = String(model.bioMarkerID)
        costLabel.text = String(model.unitPrice)
        orderPlaceOnLabel.text = orderDetails.orderDate
        orderDeliverOnLabel.text = orderDetails.orderDate

    }

}
