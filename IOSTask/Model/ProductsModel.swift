//
//  ProductsModel.swift
//  IOSTask
//
//  Created by Farido on 16/09/2024.
//

import Foundation

struct ProductsModel: Codable {
    let products: [Product]?
    let total: Int?
    let skip: Int?
    let limit: Int?
}

struct Product: Codable, Identifiable, Equatable {
    let id: Int?
    let title: String?
    let description: String?
    let sku: String?
    let category: String?
    let price: Double?
    let discountPercentage: Double?
    let rating: Double?
    let stock: Int?
    let brand: String?
    let thumbnail: String?
    let images: [String]?
    let availabilityStatus: String?
}
