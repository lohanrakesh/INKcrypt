//
//  TestSuccessTableViewCell.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 18/04/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit

class TestSuccessTableViewCell: UITableViewCell {
    
    @IBOutlet weak var qrCodeLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    //MARK:- View Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- Action
    @IBAction func initialButtonClicked(_ sender: UIButton) {
        
    }
    
}
