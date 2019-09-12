//
//  EndPointType.swift
//  INKcrypt
//
//  Created by Sandeep Kumar on 21/11/18.
//  Copyright © 2018 Q3 Technologies. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL:URL { get }
    var path:String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
