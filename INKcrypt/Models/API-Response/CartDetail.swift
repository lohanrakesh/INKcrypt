//
//  CartDetail.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 09/04/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import Foundation

class CartDetail: Decodable {
    
    var cartDetailData: CartInfoModel?
    var cartProductListData: [CartProduct]
    
    init(cartDetailData: CartInfoModel, cartProductListData: [CartProduct]) {
        self.cartDetailData = cartDetailData
        self.cartProductListData = cartProductListData
    }

}

class CartProduct: Codable {
    
    let cartDetailID: Int
    var quantity: Int
    let bioMarker: String?
    let totalPrice: Double
    let productID, productCategoryID: Int
    let productName, productDescription: String
    let imagePath: String
    let batch, expiry: String?
    let productSpecificationID, customerLevelID: Int
    let region: String?
    let discount: Int
    let currency, levelName, customerLevelDescription, productCategoryName: String
    let productCategoryDescription: String
    let productStockID: Int
    
    enum CodingKeys: String, CodingKey {
        case cartDetailID = "CartDetailID"
        case quantity = "Quantity"
        case bioMarker = "BioMarker"
        case totalPrice = "TotalPrice"
        case productID = "ProductID"
        case productCategoryID = "ProductCategoryID"
        case productName = "ProductName"
        case productDescription = "ProductDescription"
        case imagePath = "ImagePath"
        case batch
        case expiry = "Expiry"
        case productSpecificationID = "ProductSpecificationID"
        case customerLevelID = "CustomerLevelID"
        case region = "Region"
        case discount = "Discount"
        case currency = "Currency"
        case levelName = "LevelName"
        case customerLevelDescription = "CustomerLevelDescription"
        case productCategoryName = "ProductCategoryName"
        case productCategoryDescription = "ProductCategoryDescription"
        case productStockID = "ProductStockID"
    }
    
    init(cartDetailID: Int, quantity: Int, bioMarker: String?, totalPrice: Double, productID: Int, productCategoryID: Int, productName: String, productDescription: String, imagePath: String, batch: String?, expiry: String?, productSpecificationID: Int, customerLevelID: Int, region: String?, discount: Int, currency: String, levelName: String, customerLevelDescription: String, productCategoryName: String, productCategoryDescription: String, productStockID: Int) {
        self.cartDetailID = cartDetailID
        self.quantity = quantity
        self.bioMarker = bioMarker
        self.totalPrice = totalPrice
        self.productID = productID
        self.productCategoryID = productCategoryID
        self.productName = productName
        self.productDescription = productDescription
        self.imagePath = imagePath
        self.batch = batch
        self.expiry = expiry
        self.productSpecificationID = productSpecificationID
        self.customerLevelID = customerLevelID
        self.region = region
        self.discount = discount
        self.currency = currency
        self.levelName = levelName
        self.customerLevelDescription = customerLevelDescription
        self.productCategoryName = productCategoryName
        self.productCategoryDescription = productCategoryDescription
        self.productStockID = productStockID
    }
}
