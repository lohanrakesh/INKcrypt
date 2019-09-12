//
//  MyBiomarkersCodesTableViewCell.swift
//  INKcrypt
//
//  Created by Asif on 18/04/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit

protocol BioMarkersCodesDelegate : class {
    func didTapOnBioMarkersCodesViewDetailsButton(tag:Int)
}
class MyBiomarkersCodesTableViewCell: UITableViewCell {
    //Outlets\
    @IBOutlet weak var bioMarkerIdLabel: UILabel!
    @IBOutlet weak var certificateNoLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var testPartlabel: UILabel!
    @IBOutlet weak var registrationOnLabel: UILabel!
    @IBOutlet weak var expiresOnLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var testerSettingLabel: UILabel!
    @IBOutlet weak var bmiSwitch: UISwitch!
    @IBOutlet weak var viewDetailButton: UIButton!
    weak var delegate : BioMarkersCodesDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureBioMarkersCodesCell(model:BioMarkersCodesModel)  {
        if let markersId = model.bioMarkerId {
            bioMarkerIdLabel.text = markersId
        }
        if let certificateNo = model.certificateNo {
            certificateNoLabel.text = certificateNo
        }
        if let type = model.type {
            typeLabel.text = type
        }
        if let testPart = model.testPart {
            testPartlabel.text = testPart
        }
        if let registrationOn = model.registrationOn {
            registrationOnLabel.text = registrationOn
        }
        if let expiresOn = model.expiresOn {
            expiresOnLabel.text = expiresOn
        }
        if let description = model.description {
            descriptionLabel.text = description
        }
        if let count = model.count {
            countLabel.text = count
        }
        if let testerSetting = model.testerSetting {
            testerSettingLabel.text = testerSetting
        }
        if let bmi = model.bmi {
            bmiSwitch.isOn = bmi
        }
        
    }
    @IBAction func viewDetailButtonACtion(_ sender: UIButton) {
        delegate?.didTapOnBioMarkersCodesViewDetailsButton(tag: sender.tag)
    }
    
}
