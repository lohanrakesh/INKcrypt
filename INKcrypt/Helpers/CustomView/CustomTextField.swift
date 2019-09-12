//
//  CustomTextField.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 27/03/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

@IBDesignable
class CustomTextField: UITextField {
    
    @IBInspectable var insetX: CGFloat = 0
    @IBInspectable var insetY: CGFloat = 0
    
    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
    
    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
}

