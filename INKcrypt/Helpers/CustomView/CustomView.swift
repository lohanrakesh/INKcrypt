//
//  CustomView.swift
//

import UIKit

@IBDesignable
class CustomView: UIView {
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
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.clipsToBounds = true
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    private static var addShadow:Bool = false
    
    @IBInspectable var addShadow:Bool = false{
        didSet(newValue) {
            if newValue == true {
                layer.masksToBounds = false
                layer.shadowColor = UIColor.black.cgColor
                layer.shadowOpacity = 0.075
                layer.shadowOffset = CGSize(width: 0, height: -3)
                layer.shadowRadius = 1
                
                layer.shadowPath = UIBezierPath(rect: bounds).cgPath
                layer.shouldRasterize = true
                layer.rasterizationScale =  UIScreen.main.scale
            }
        }
    }

}

class CustomLabel: UILabel {
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
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.clipsToBounds = true
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    private static var addShadow:Bool = false
    
    @IBInspectable var addShadow:Bool = false{
        didSet(newValue) {
            if newValue == true {
                layer.masksToBounds = false
                layer.shadowColor = UIColor.black.cgColor
                layer.shadowOpacity = 0.075
                layer.shadowOffset = CGSize(width: 0, height: -3)
                layer.shadowRadius = 1
                
                layer.shadowPath = UIBezierPath(rect: bounds).cgPath
                layer.shouldRasterize = true
                layer.rasterizationScale =  UIScreen.main.scale
            }
        }
    }
    
}

class CustomImageView: UIImageView {
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
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.clipsToBounds = true
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    private static var addShadow:Bool = false
    
    @IBInspectable var addShadow:Bool = false{
        didSet(newValue) {
            if newValue == true {
                layer.masksToBounds = false
                layer.shadowColor = UIColor.black.cgColor
                layer.shadowOpacity = 0.075
                layer.shadowOffset = CGSize(width: 0, height: -3)
                layer.shadowRadius = 1
                
                layer.shadowPath = UIBezierPath(rect: bounds).cgPath
                layer.shouldRasterize = true
                layer.rasterizationScale =  UIScreen.main.scale
            }
        }
    }
    
}

class CustomButton: UIButton {
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
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.clipsToBounds = true
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    private static var addShadow:Bool = false
    
    @IBInspectable var addShadow:Bool = false{
        didSet(newValue) {
            if newValue == true {
                layer.masksToBounds = false
                layer.shadowColor = UIColor.init(red: 224.0/256.0, green: 224.0/256.0, blue: 224.0/256.0, alpha: 1.0).cgColor
                layer.shadowOpacity = 0.1
                layer.shadowOffset = CGSize(width: 0, height: -3)
                layer.shadowRadius = 2
                
                layer.shadowPath = UIBezierPath(rect: bounds).cgPath
                layer.shouldRasterize = true
                layer.rasterizationScale =  UIScreen.main.scale
            }
        }
    }
    
}




