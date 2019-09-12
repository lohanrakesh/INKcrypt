//
//  HomeProductCollectionViewCell.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 25/03/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit

class HomeProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productBuyButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
