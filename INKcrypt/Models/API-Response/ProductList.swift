//
//  ProductList.swift
//  INKcrypt
//
//  Created by Rakesh Lohan on 01/04/19.
//  Copyright © 2019 Q3 Technologies. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class StoreElement: Decodable {

    let productListElements: [ProductListElement]?

    
    enum CodingKeys: String, CodingKey {
        case productListElements = "productCategoryDatas"
    }
    
    init(productListElements: [ProductListElement]?) {

        self.productListElements = productListElements
    }
}

class ProductListElement: Decodable {
    let productCategoryID: Int?
    let productCategoryName: String?
    let productCategoryDescription: String?
    let productDataList: [ProductDataList]?
    let isActive: Bool?
    let createdBy: Int?
    let modifiedBy: String?
    let createdDate: String?
    let modifiedDate: String?
    
    enum CodingKeys: String, CodingKey {
        case productCategoryID = "ProductCategoryID"
        case productCategoryName = "ProductCategoryName"
        case productCategoryDescription = "ProductCategoryDescription"
        case productDataList = "productDataList"
        case isActive = "IsActive"
        case createdBy = "CreatedBy"
        case modifiedBy = "ModifiedBy"
        case createdDate = "CreatedDate"
        case modifiedDate = "ModifiedDate"
    }
    
    init(productCategoryID: Int?, productCategoryName: String?, productCategoryDescription: String?, productDataList: [ProductDataList]?, isActive: Bool?, createdBy: Int?, modifiedBy: String?, createdDate: String?, modifiedDate: String?) {
        self.productCategoryID = productCategoryID
        self.productCategoryName = productCategoryName
        self.productCategoryDescription = productCategoryDescription
        self.productDataList = productDataList
        self.isActive = isActive
        self.createdBy = createdBy
        self.modifiedBy = modifiedBy
        self.createdDate = createdDate
        self.modifiedDate = modifiedDate
    }
}

class ProductDataList: Decodable {
    
    let productID: Int
    let productName, productDescription: String
    let imageString, batch: String?
    let productSpecificationID, customerLevelID: Int
    let region: String?
    let price: Double
    let discount: Int
    let currency, levelName: String
    let customerLevelDescription: String?
    let productStockID, quantity, availableQuantity, damagedQuantity: Int
    var returnedQuantity, holdQuantity: Int
    var cartQuantity: Int
    let isActive: Bool
    let createdBy: Int
    let modifiedBy: String?
    let createdDate: String
    let modifiedDate: String?
    
    var quantityAdded = 1
    
    enum CodingKeys: String, CodingKey {
        case productID = "ProductID"
        case productName = "ProductName"
        case productDescription = "ProductDescription"
        case imageString = "ImagePath"
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
    
    init(productID: Int, productName: String, productDescription: String, imageString: String?, batch: String?, productSpecificationID: Int, customerLevelID: Int, region: String?, price: Double, discount: Int, currency: String, levelName: String, customerLevelDescription: String?, productStockID: Int, quantity: Int, availableQuantity: Int, damagedQuantity: Int, returnedQuantity: Int, holdQuantity: Int, cartQuantity: Int, isActive: Bool, createdBy: Int, modifiedBy: String?, createdDate: String, modifiedDate: String?) {
        
        self.productID = productID
        self.productName = productName
        self.productDescription = productDescription
        self.imageString = imageString
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

class CartInfoModel : Codable {

let cartID, cartItemTotal, tax: Int
let shippingCharges: Int
let promoDiscount, promoCode: String?
let cartTotal, cartSubTotal: Double

enum CodingKeys: String, CodingKey {
    case cartID = "CartID"
    case cartItemTotal = "CartItemTotal"
    case cartSubTotal = "CartSubTotal"
    case tax = "Tax"
    case shippingCharges = "ShippingCharges"
    case promoDiscount = "PromoDiscount"
    case promoCode = "PromoCode"
    case cartTotal = "CartTotal"
}

init(cartID: Int, cartItemTotal: Int, cartSubTotal: Double, tax: Int, shippingCharges: Int, promoDiscount: String?, promoCode: String?, cartTotal: Double) {
    self.cartID = cartID
    self.cartItemTotal = cartItemTotal
    self.cartSubTotal = cartSubTotal
    self.tax = tax
    self.shippingCharges = shippingCharges
    self.promoDiscount = promoDiscount
    self.promoCode = promoCode
    self.cartTotal = cartTotal
}
}

class DeliveryType: Decodable {
    
    let deliveryTypeID: Int
    let type: String
    let deliveryCharges: Int
    
    enum CodingKeys: String, CodingKey {
        case deliveryTypeID = "DeliveryTypeID"
        case type = "Type"
        case deliveryCharges = "DeliveryCharges"
    }
    
    init(deliveryTypeID: Int, type: String, deliveryCharges: Int) {
        self.deliveryTypeID = deliveryTypeID
        self.type = type
        self.deliveryCharges = deliveryCharges
    }
}




