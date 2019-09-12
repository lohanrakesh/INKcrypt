//
//  PatternImageTableViewCell.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 22/02/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit

class PatternImageTableViewCell: UITableViewCell {

    @IBOutlet weak var qrId: UILabel!
    @IBOutlet weak var qrCodeImageView: UIImageView!
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonB: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
