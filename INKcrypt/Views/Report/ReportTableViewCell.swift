//
//  ReportTableViewCell.swift
//  INKcrypt
//
//  Created by Asif on 11/04/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit

protocol OpenDetailVcDelegate:class {
    func openDetailVcForRow(row : Int)
}

class ReportTableViewCell: UITableViewCell {
    //Outlets
    @IBOutlet weak var bioMarkerId: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    weak var delegate : OpenDetailVcDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    public func configureReportCell(model:MapInfoWindowModel) {
        bioMarkerId.text = model.bioMarkerID
        itemLabel.text = model.itemLabel
        descriptionLabel.text = model.description
        resultLabel.text = model.result
        dateLabel.text = model.date
        timeLabel.text = model.time
        statusLabel.text = model.status
    }
    
    @IBAction func viewDetailsButtonAction(_ sender: UIButton) {
        delegate?.openDetailVcForRow(row: sender.tag)
    }
}
