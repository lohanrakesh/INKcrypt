//
//  AccountTableViewCell.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 2/22/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

class AccountTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!

    func configureAccountTableViewCell(info : AccountInfo) {
        if let image = UIImage(named: info.imageName) {
          iconImageView.image = image
        }
        infoLabel.text = info.discription
    }
}
