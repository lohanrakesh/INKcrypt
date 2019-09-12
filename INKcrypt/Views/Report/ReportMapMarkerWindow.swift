//
//  ReportMapMarkerWindow.swift
//  INKcrypt
//
//  Created by Asif on 15/04/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit

protocol MapMarkerDelegate: class {
    func didTapDetailButton(spotData: MapInfoWindowModel?)
}

class ReportMapMarkerWindow: UIView {
    //Outlets
    @IBOutlet weak var bioMarkerId: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    weak var delegate: MapMarkerDelegate?
    var spotData: MapInfoWindowModel?
    
    
    @IBAction func didTapDetailsButton(_ sender: UIButton) {
        delegate?.didTapDetailButton(spotData: spotData)
    }
    
    class func instanceFromNib() -> UIView {
        if let view = UINib(nibName: "ReportMapMarkerWindow", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView { return view } else {
            return UIView()
        }
    }
}



