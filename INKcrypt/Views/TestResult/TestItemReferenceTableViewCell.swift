//
//  TestItemReferenceTableViewCell.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 18/04/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit

class TestItemReferenceTableViewCell: UITableViewCell {
    
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
    
    //MARk:- Action
    @IBAction func likeButtonClicked(_ sender: UIButton){
        
    }
    
    @IBAction func unlikeButtonClicked(_ sender: UIButton){
        
    }
    
    @IBAction func shareButtonClicked(_ sender: UIButton){
        
        if let viewC = self.parentViewController as? TestResultViewController {
            
            var screenShotImage :UIImage?
            let layer = UIApplication.shared.keyWindow!.layer
            let scale = UIScreen.main.scale
            UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
            guard let context = UIGraphicsGetCurrentContext() else {return }
            layer.render(in:context)
            screenShotImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            if let image = screenShotImage {
                let activityViewController = UIActivityViewController(activityItems: [image] , applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = viewC.view
                viewC.present(activityViewController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func getValueCodeButtonClicked(_ sender: UIButton){
        
    }
    
}
