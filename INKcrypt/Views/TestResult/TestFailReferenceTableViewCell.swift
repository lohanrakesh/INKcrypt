//
//  TestFailReferenceTableViewCell.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 18/04/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit

class TestFailReferenceTableViewCell: UITableViewCell {

    @IBOutlet weak var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textView.layer.cornerRadius = 6.0
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.init(red: 213.0/255.0, green: 212.0/255.0, blue: 212.0/255.0, alpha: 1.0).cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        // Configure the view for the selected state
    }
    
}
