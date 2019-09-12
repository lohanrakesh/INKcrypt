//
//  NotificationTableViewCell.swift
//  INKcrypt
//
//  Created by Asif on 18/04/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    /// Populate data into cell from model;
    ///
    /// - Parameter model: notification model
    func configureNotificationCell(model:NotificationModel)  {
        titleLabel.text = model.title
        subTitleLabel.text = model.subTitle
        timeLabel.text = model.time
    }
    
}
