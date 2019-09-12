//
//  EditAddressTableViewCell.swift
//  INKcrypt
//
//  Created by Vishal Ahlawat on 3/6/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

typealias AddressSelection = (_ address: AddressInfoModel) -> ()

class EditAddressTableViewCell : UITableViewCell {
    
     @IBOutlet weak var titleLabel: UILabel!
    
    func configureEditAddressCell() {
        
    }
    
    @IBAction func editAddressButtonPressed(_ sender: Any) {
        debugPrint("Edit address button clicked")
        if let viewC = parentViewController as? CartViewController {
            guard let addressViewController = UIStoryboard.accountStoryboard().instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.addressViewController) as? AddressViewController else {
                return
            }
            addressViewController.selectedAddress =  {
                address in
                self.titleLabel.text = address.shipAddress1 + ", " + address.shipAddress2 + ", " + address.cityName + ", " + address.stateName + ", " + address.countryName + ", " + address.zipcode
            }
            viewC.present(addressViewController, animated: true, completion: nil)
        }
    }
}
