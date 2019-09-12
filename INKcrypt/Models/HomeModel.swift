//
//  HomeModel.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 25/04/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

class HomeModel: Codable {
    
    let authenticationPages: [AuthenticationPage]
    let productDataList: HomeHeading
    
    init(authenticationPages: [AuthenticationPage], productDataList: HomeHeading) {
        self.authenticationPages = authenticationPages
        self.productDataList = productDataList
    }
}

class AuthenticationPage: Codable {
    let pageURL: String
    
    enum CodingKeys: String, CodingKey {
        case pageURL = "PageURL"
    }
    
    init(pageURL: String) {
        self.pageURL = pageURL
    }
}

class HomeHeading: Codable {
    let heading, subHeading: String
    var products: [HomeProduct]
    
    enum CodingKeys: String, CodingKey {
        case heading = "Heading"
        case subHeading = "SubHeading"
        case products = "productDataList"
    }
    
    init(heading: String, subHeading: String, productDataList: [HomeProduct]) {
        self.heading = heading
        self.subHeading = subHeading
        self.products = productDataList
    }
}

class HomeProduct: Codable {
    
    let productID: Int
    let productName, productDescription: String
    let imagePath: String
    let batch: String?
    let productSpecificationID, customerLevelID: Int
    let region: String?
    let price: Double
    let discount: Int
    let currency, levelName, customerLevelDescription: String
    let productStockID, quantity, availableQuantity, damagedQuantity: Int
    let returnedQuantity, holdQuantity, cartQuantity: Int
    let isActive: Bool
    let createdBy: Int
    let modifiedBy: String?
    let createdDate: String
    let modifiedDate: String?
    
    enum CodingKeys: String, CodingKey {
        case productID = "ProductID"
        case productName = "ProductName"
        case productDescription = "ProductDescription"
        case imagePath = "ImagePath"
        case batch
        case productSpecificationID = "ProductSpecificationID"
        case customerLevelID = "CustomerLevelID"
        case region = "Region"
        case price = "Price"
        case discount = "Discount"
        case currency = "Currency"
        case levelName = "LevelName"
        case customerLevelDescription = "CustomerLevelDescription"
        case productStockID = "ProductStockID"
        case quantity = "Quantity"
        case availableQuantity = "AvailableQuantity"
        case damagedQuantity = "DamagedQuantity"
        case returnedQuantity = "ReturnedQuantity"
        case holdQuantity = "HoldQuantity"
        case cartQuantity = "CartQuantity"
        case isActive = "IsActive"
        case createdBy = "CreatedBy"
        case modifiedBy = "ModifiedBy"
        case createdDate = "CreatedDate"
        case modifiedDate = "ModifiedDate"
    }
    
    init(productID: Int, productName: String, productDescription: String, imagePath: String, batch: String?, productSpecificationID: Int, customerLevelID: Int, region: String?, price: Double, discount: Int, currency: String, levelName: String, customerLevelDescription: String, productStockID: Int, quantity: Int, availableQuantity: Int, damagedQuantity: Int, returnedQuantity: Int, holdQuantity: Int, cartQuantity: Int, isActive: Bool, createdBy: Int, modifiedBy: String?, createdDate: String, modifiedDate: String?) {
        self.productID = productID
        self.productName = productName
        self.productDescription = productDescription
        self.imagePath = imagePath
        self.batch = batch
        self.productSpecificationID = productSpecificationID
        self.customerLevelID = customerLevelID
        self.region = region
        self.price = price
        self.discount = discount
        self.currency = currency
        self.levelName = levelName
        self.customerLevelDescription = customerLevelDescription
        self.productStockID = productStockID
        self.quantity = quantity
        self.availableQuantity = availableQuantity
        self.damagedQuantity = damagedQuantity
        self.returnedQuantity = returnedQuantity
        self.holdQuantity = holdQuantity
        self.cartQuantity = cartQuantity
        self.isActive = isActive
        self.createdBy = createdBy
        self.modifiedBy = modifiedBy
        self.createdDate = createdDate
        self.modifiedDate = modifiedDate
    }
}
