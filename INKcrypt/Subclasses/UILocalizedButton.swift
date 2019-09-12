//
//  UILocalizedButton.swift
//  INKcrypt
//
//  Created by Sandeep Kumar on 28/07/18.
//  Copyright © 2018 Q3 Technologies. All rights reserved.
//

import UIKit

@IBDesignable final class UILocalizedButton: UIButton {
    
    @IBInspectable var tableName: String? {
        didSet {
            guard let tableName = tableName else { return }
            let title = self.title(for: .normal)?.localized(tableName: tableName)
            setTitle(title, for: .normal)
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
            self.clipsToBounds = true
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
            self.clipsToBounds = true
        }
    }
    
    @IBInspectable var backGroundColor: UIColor = UIColor.clear {
        didSet {
           self.backgroundColor = backgroundColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.clipsToBounds = true
        }
    }
    
    @IBInspectable var fontName : UIFont = UIFont.boldSystemFont(ofSize: 14.0) {
        didSet {
            self.titleLabel?.font = fontName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        /*
        self.titleLabel?.font = Font(.installed(.RobotoMedium), size: .standard(.h3)).instance
        self.setTitleColor(UIColor.white, for: .normal)
        self.backgroundColor = UIColor.cherryRed
        self.layer.cornerRadius = 5;
        */
    }
}
