//
//  OrderHeaderView.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 3/8/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

let KOrderHeaderViewNibName = "OrderHeaderView"

class OrderHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var infoLabel: UILabel!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: KProfileTableHeaderViewNibName)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configureOrderHeaderViewWithInfo(orderID : String) {
        infoLabel.text = orderID
    }
    
    @IBAction func orderDetailsButtonPressed(_ sender: Any) {

    }
}
