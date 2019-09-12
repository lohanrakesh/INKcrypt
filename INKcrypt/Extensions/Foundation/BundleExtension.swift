//
//  BundleExtension.swift
//  INKcrypt
//
//  Created by Sandeep Kumar on 28/07/18.
//  Copyright © 2018 Q3 Technologies. All rights reserved.
//

import Foundation
extension Bundle {
    var displayName: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
}
