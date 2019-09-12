//
//  UILocalizedLabel.swift
//  INKcrypt
//
//  Created by Sandeep Kumar on 28/07/18.
//  Copyright © 2018 Q3 Technologies. All rights reserved.
//

import UIKit

@IBDesignable final class UILocalizedLabel: UILabel {
    @IBInspectable var tableName: String? {
        didSet {
            guard let tableName = tableName else { return }
            text = text?.localized(tableName: tableName)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
