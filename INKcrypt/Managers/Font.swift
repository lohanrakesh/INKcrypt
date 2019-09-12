//
//  Font.swift
//  Emax
//
//  Created by Sandeep Kumar on 05/01/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation
import UIKit

// Usage Examples
let system12            = Font(.system, size: .standard(.hh5)).instance
let robotoThin20        = Font(.installed(.robotoThin), size: .standard(.hh1)).instance
let robotoBlack14       = Font(.installed(.robotoBlack), size: .standard(.hh4)).instance
let helveticaLight13    = Font(.custom("Helvetica-Light"), size: .custom(13.0)).instance

struct Font {
    
    enum FontType {
        case installed(FontName)
        case custom(String)
        case system
        case systemBold
        case systemItatic
        case systemWeighted(weight: Double)
        case monoSpacedDigit(size: Double, weight: Double)
    }
    enum FontSize {
        case standard(StandardSize)
        case custom(Double)
        var value: Double {
            switch self {
            case .standard(let size):
                return size.rawValue
            case .custom(let customSize):
                return customSize
            }
        }
    }
    enum FontName: String {
        case robotoBlack            = "Roboto-Black"
        case robotoBlackItalic      = "Roboto-BlackItalic"
        case robotoBold             = "Roboto-Bold"
        case robotoBoldItalic       = "Roboto-BoldItalic"
        case robotoItalic           = "Roboto-Italic"
        case robotoLight            = "Roboto_Light"
        case robotoLightItalic      = "Roboto-LightItalic"
        case robotoMedium           = "Roboto-Medium"
        case robotoMediumItalic     = "Roboto-MediumItalic"
        case robotoRegular          = "Roboto-Regular"
        case robotoThin             = "Roboto-Thin"
        case robotoThinItalic       = "Roboto-ThinItalic"
    }
    enum StandardSize: Double {
        case hh1 = 20.0
        case hh2 = 18.0
        case hh3 = 16.0
        case hh4 = 14.0
        case hh5 = 12.0
        case hh6 = 10.0
    }
    
    
    var type: FontType
    var size: FontSize
    init(_ type: FontType, size: FontSize) {
        self.type = type
        self.size = size
    }
}

extension Font {
    
    var instance: UIFont {
        
        var instanceFont: UIFont!
        switch type {
        case .custom(let fontName):
            guard let font =  UIFont(name: fontName, size: CGFloat(size.value)) else {
                fatalError("\(fontName) font is not installed, make sure it added in Info.plist and logged with Utility.logAllAvailableFonts()")
            }
            instanceFont = font
        case .installed(let fontName):
            guard let font =  UIFont(name: fontName.rawValue, size: CGFloat(size.value)) else {
                fatalError("\(fontName.rawValue) font is not installed, make sure it added in Info.plist and logged with Utility.logAllAvailableFonts()")
            }
            instanceFont = font
        case .system:
            instanceFont = UIFont.systemFont(ofSize: CGFloat(size.value))
        case .systemBold:
            instanceFont = UIFont.boldSystemFont(ofSize: CGFloat(size.value))
        case .systemItatic:
            instanceFont = UIFont.italicSystemFont(ofSize: CGFloat(size.value))
        case .systemWeighted(let weight):
            instanceFont = UIFont.systemFont(ofSize: CGFloat(size.value),
                                             weight: UIFont.Weight(rawValue: CGFloat(weight)))
        case .monoSpacedDigit(let size, let weight):
            instanceFont = UIFont.monospacedDigitSystemFont(ofSize: CGFloat(size),
                                                            weight: UIFont.Weight(rawValue: CGFloat(weight)))
        }
        return instanceFont
    }
}

