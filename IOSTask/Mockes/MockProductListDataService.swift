//
//  MockProductService.swift
//  IOSTask
//
//  Created by Farido on 17/09/2024.
//

import Foundation
import Combine

class MockProductListDataService: ProductListDataService {
    @Published var error: Error? = nil
    override func getProducts(byCategory: String?) {
        products = [Product(id: 1, title: "Annibale Colombo Bed", description: "The Annibale Colombo Bed is a luxurious and elegant bed frame, crafted with high-quality materials for a comfortable and stylish bedroom.", sku: "36T6X4M3", category: "furniture", price: 1899.99, discountPercentage: 0.29, rating: 4.14, stock: 47, brand: "Annibale Colombo", thumbnail: "https://cdn.dummyjson.com/products/images/furniture/Annibale%20Colombo%20Bed/thumbnail.png", images: ["https://cdn.dummyjson.com/products/images/womens-watches/Women's%20Wrist%20Watch/1.png",
             "https://cdn.dummyjson.com/products/images/womens-watches/Women's%20Wrist%20Watch/2.png",
             "https://cdn.dummyjson.com/products/images/womens-watches/Women's%20Wrist%20Watch/3.png"], availabilityStatus: "In Stock")]
    }
}
