//
//  AddressTableViewCell.swift
//  INKcrypt
//
//  Created by Asif on 27/02/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {

    @IBOutlet weak var upperViewHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var addressLabel: UILabel!
    
    var indexPath = IndexPath()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func configureAddressCell(addressInfo:AddressInfoModel, indexPath : IndexPath) {
      //  addressLabel.text = "\(addressInfo.addressLine1),\(addressInfo.addressLine2),\(addressInfo.country),\(addressInfo.city),\(addressInfo.state),\(addressInfo.zipcode)"
        self.indexPath = indexPath
        if indexPath.section == 0 {
            upperViewHeightConstraints.constant = 0
        } else {
            upperViewHeightConstraints.constant = 12
        }
        addressLabel.text = addressInfo.shipAddress1 + ", " + addressInfo.shipAddress2 + ", " + addressInfo.cityName + ", " + addressInfo.stateName + ", " + addressInfo.countryName + ", " + addressInfo.zipcode
    }
    
    @IBAction func editButtonPressed(_ sender: Any) {
        if let viewC = parentViewController as? AddressViewController {
            viewC.editButtonPressedForIndexPath(indexPath: indexPath)
        }
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        if let viewC = parentViewController as? AddressViewController {
            viewC.deleteButtonPressedForIndexPath(indexPath: indexPath)
        }
    }
    
}
