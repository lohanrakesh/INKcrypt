//
//  StringExtension.swift
//  INKcrypt
//
//  Created by Sandeep Kumar on 28/07/18.
//  Copyright © 2018 Q3 Technologies. All rights reserved.
//

import Foundation
import CommonCrypto

extension String {
    
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "\(self)", comment: "")
    }
    
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    func genrateQrCode() -> UIImage?{
        // Get define string to encode
        let myString = self
        // Get data from the string
        let data = myString.data(using: String.Encoding.utf8)
        // Get a QR CIFilter
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil}
        // Input the data
        qrFilter.setValue(data, forKey: "inputMessage")
        // Get the output image
        guard let qrImage = qrFilter.outputImage else { return nil }
        // Scale the image
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledQrImage = qrImage.transformed(by: transform)
        // Do some processing to get the UIImage
        let context = CIContext()
        guard let cgImage = context.createCGImage(scaledQrImage, from: scaledQrImage.extent) else { return nil }
        let processedImage = UIImage(cgImage: cgImage)
        return processedImage
    }
    
    func sha512Hex() -> String {
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
        if let data = self.data(using: String.Encoding.utf8) {
            let value =  data as NSData
            CC_SHA512(value.bytes, CC_LONG(data.count), &digest)
            
        }
        var digestHex = ""
        for index in 0..<Int(CC_SHA512_DIGEST_LENGTH) {
            digestHex += String(format: "%02x", digest[index])
        }
        
        return digestHex
    }
    
    
    func sha512() -> [UInt8] {
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
        let data = self.data(using: String.Encoding.utf8 , allowLossyConversion: true)
        let value =  data! as NSData
        CC_SHA512(value.bytes, CC_LONG(value.length), &digest)
        
        return digest
    }
    
    func sha512Base64() -> String {
        let digest = NSMutableData(length: Int(CC_SHA512_DIGEST_LENGTH))!
        if let data = self.data(using: String.Encoding.utf8) {
            
            let value =  data as NSData
            let uint8Pointer = UnsafeMutablePointer<UInt8>.allocate(capacity: digest.length)
            CC_SHA512(value.bytes, CC_LONG(data.count), uint8Pointer)
            
        }
        return digest.base64EncodedString(options: NSData.Base64EncodingOptions([]))
    }
    
    
    
    func base64ToImage() -> UIImage? {
        if let decodedData = Data(base64Encoded: self, options: .ignoreUnknownCharacters) {
            let image = UIImage(data: decodedData)
             return image
        } else {
        return nil
        }
    }
}
