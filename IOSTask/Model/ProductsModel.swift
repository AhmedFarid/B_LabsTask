//
//  ProductsModel.swift
//  IOSTask
//
//  Created by Farido on 16/09/2024.
//

import Foundation

struct ProductsModel: Codable {
    var products: [Product]?
    var total, skip, limit: Int?
}

struct Product: Codable, Identifiable, Equatable {
    var id: Int?
    var title, description, sku, category: String?
    var price, discountPercentage, rating: Double?
    var stock: Int?
    var brand: String?
    var thumbnail: String?
    var images: [String]?
    var availabilityStatus: String?
}

 
