//
//  SampleModel.swift
//  INKcrypt
//
//  Created by Sandeep Kumar on 19/02/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

class ImagePatternResponse: Codable {
    
    let success: Bool?
    let code: Int?
    let message: String?
    let result: String?
    
    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case code = "Code"
        case message = "Message"
        case result = "Data"
    }
    
    init(success: Bool?, code: Int?, message: String?, data: String?) {
        self.success = success
        self.code = code
        self.message = message
        self.result = data
    }
}

fileprivate func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

fileprivate func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
