//
//  UILocalizedTextField.swift
//  INKcrypt
//
//  Created by Sandeep Kumar on 28/07/18.
//  Copyright © 2018 Q3 Technologies. All rights reserved.
//

import UIKit

import SkyFloatingLabelTextField

@IBDesignable final class UILocalizedTextField: SkyFloatingLabelTextFieldWithIcon
{
    @IBInspectable var tableName: String? {
        didSet {
            guard let tableName = tableName else { return }
            text = text?.localized(tableName: tableName)
            placeholder = placeholder?.localized(tableName: tableName)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.iconImageView.contentMode = .scaleAspectFit
        //self.iconMarginBottom = 4
        self.lineHeight = 1.0
        self.selectedLineHeight = 1.0
        self.selectedTitleColor = UIColor.gunmetal
        //self.selectedTitle = self.selectedTitle?.lowercased()
        //self.placeholder = self.placeholder?.uppercased()
        let robotoRegular14 = Font(.installed(.robotoRegular), size: .standard(.hh4)).instance
        self.font =  robotoRegular14
        self.placeholderFont = robotoRegular14
        self.placeholderColor = UIColor.brownGreyTwo
    }
    
    // MARK: Override SkyFloatingLabelTextField method to vertically center the text
    
    override func titleLabelRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
        
        var rect = super.titleLabelRectForBounds(bounds, editing: editing)
        rect.origin.y += 3
        
        if self.iconType == .image {
            if isLTRLanguage {
                rect.origin.x += CGFloat(iconWidth + iconMarginLeft)
            } else {
                rect.origin.x -= CGFloat(iconWidth + iconMarginLeft)
            }
        }else{
            if isLTRLanguage {
                rect.origin.x += 3
            }else{
                rect.origin.x -= 3
            }
        }
        return rect
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        
        var rect = super.textRect(forBounds: bounds)
        //rect.origin.y -= 5
        if self.iconType == .image {
            if isLTRLanguage == false {
                rect.origin.x += CGFloat(iconWidth + iconMarginLeft) 
            }
        }
        return rect
    }
    
//    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//        var rect = super.placeholderRect(forBounds: bounds)
//        rect.origin.y -= 5
//        return rect
//    }
    
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        let rect = super.editingRect(forBounds: bounds)
//        rect.origin.y -= 5
//        return rect
//    }
}


@IBDesignable final class UILocalizedTextFieldWithoutImage: SkyFloatingLabelTextField
{
    @IBInspectable var tableName: String? {
        didSet {
            guard let tableName = tableName else { return }
            text = text?.localized(tableName: tableName)
            placeholder = placeholder?.localized(tableName: tableName)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lineHeight = 1.0
        self.selectedLineHeight = 1.0
        self.selectedTitleColor = UIColor.gunmetal
        self.selectedTitle = self.selectedTitle?.lowercased()
        //self.placeholder = self.placeholder?.uppercased()
        let robotoRegular14 = Font(.installed(.robotoRegular), size: .standard(.hh4)).instance
        self.font =  robotoRegular14
        self.placeholderFont = robotoRegular14
        self.placeholderColor = UIColor.brownGreyTwo
    }
    
    // MARK: Override SkyFloatingLabelTextField method to vertically center the text
    
//    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//        var rect = super.placeholderRect(forBounds: bounds)
//        rect.origin.y -= 5
//        return rect
//    }
    
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        var rect = super.editingRect(forBounds: bounds)
//        rect.origin.y -= 5
//        return rect
//    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.textRect(forBounds: bounds)
        rect.origin.y -= 5
        return rect
    }
}
