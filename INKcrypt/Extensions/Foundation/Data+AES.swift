//
//  Data+AES.swift
//  StudentApp
//
//  Created by pardeep kumar on 20/11/18.
//  Copyright © 2018 pardeep kumar. All rights reserved.
//

import Foundation
import UIKit
import CommonCrypto

 fileprivate var context = UnsafeMutablePointer<CCCryptorRef?>.allocate(capacity: 1)
extension Data {
    func aesEncrypt(key: String, iv: String, options: Int = kCCOptionPKCS7Padding) -> Data? {
        if let cryptData = NSMutableData(length: Int((self.count)) + kCCBlockSizeAES128), let keyData = key.data(using: .utf8) {
            let keyLength: size_t = size_t(kCCKeySizeAES128)
            let operation: CCOperation = UInt32(kCCEncrypt)
            let algoritm: CCAlgorithm = UInt32(kCCAlgorithmAES)
            let options: CCOptions = UInt32(options)
            
            var numBytesEncrypted: size_t = 0
            
            let cryptStatus = keyData.withUnsafeBytes { mykeydataBytes in
                self.withUnsafeBytes({ myRawDataBytes in
                    CCCrypt(operation,
                            algoritm,
                            options,
                            mykeydataBytes, keyLength,
                            iv,
                            myRawDataBytes, self.count,
                            cryptData.mutableBytes, cryptData.length,
                            &numBytesEncrypted)
                })
            }
            
            if UInt32(cryptStatus) == UInt32(kCCSuccess) {
                cryptData.length = Int(numBytesEncrypted)
                return cryptData as Data
            }
            else {
                return nil
            }
        }
        return nil
    }
    
    func aesDecrypt(key: String, iv: String, options: Int = kCCOptionPKCS7Padding) -> Data? {
        if let cryptData = NSMutableData(length: Int((self.count)) + kCCBlockSizeAES128), let keyData = key.data(using: .utf8) {
            let keyLength: size_t = size_t(kCCKeySizeAES128)
            let operation: CCOperation = UInt32(kCCDecrypt)
            let algoritm: CCAlgorithm = UInt32(kCCAlgorithmAES)
            let options: CCOptions = UInt32(options)
            
            var numBytesEncrypted: size_t = 0
            
            
            let cryptStatus = keyData.withUnsafeBytes { mykeydataBytes in
                self.withUnsafeBytes({ myRawDataBytes in
                    CCCrypt(operation,
                            algoritm,
                            options,
                            mykeydataBytes, keyLength,
                            iv,
                            myRawDataBytes, self.count,
                            cryptData.mutableBytes, cryptData.length,
                            &numBytesEncrypted)
                })
            }
            
            if UInt32(cryptStatus) == UInt32(kCCSuccess) {
                cryptData.length = Int(numBytesEncrypted)
                return cryptData as Data
            }
            else {
                return nil
            }
        }
        return nil
    }
}

extension String {
    func aesEncrypt() -> String? {
        guard let base64String =  self.toBase64(),let data = Data(base64Encoded: base64String) else {return nil}
        if let encrypt = data.aesEncrypt(key: ConfigurationManager.sharedManager().aESEncryptionSecretKey(), iv:ConfigurationManager.sharedManager().aESEncryptionIVKey()) {
            return encrypt.base64EncodedString()
        } else {return nil }
    }
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self, options: Data.Base64DecodingOptions(rawValue: 0)) else {
            return nil
        }
        return String(data: data as Data, encoding: String.Encoding.utf8)
    }
    
    func toBase64() -> String? {
        guard let data = self.data(using: String.Encoding.utf8) else {
            return nil
        }
        return data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
    }
}
