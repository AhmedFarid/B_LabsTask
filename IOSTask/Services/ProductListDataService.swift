//
//  ProductListDataService.swift
//  IOSTask
//
//  Created by Farido on 16/09/2024.
//

import Foundation
import Combine

protocol ProductListDataServiceProtocol {
    func getCategories() -> AnyPublisher<[Category], Error>
    func getProducts(byCategory: String?) -> AnyPublisher<ProductsModel, Error>
    func loadMoreItem(limit: Int, skip: Int, byCategory: String?) -> AnyPublisher<ProductsModel, Error>
    func getProductDetails(productId: Int) -> AnyPublisher<Product, Error>
}

class ProductListDataService: ProductListDataServiceProtocol {

    init() {}

    func getCategories() -> AnyPublisher<[Category], Error> {
        guard let url = URL(string: "https://dummyjson.com/products/categories") else {
            return Fail(error: NetworkingError.invalidURL)
                .eraseToAnyPublisher()
        }
        return NetworkingManger.fetch(url: url)
            .eraseToAnyPublisher()
    }

    func getProducts(byCategory: String?) -> AnyPublisher<ProductsModel, any Error> {
        var url = ""
        url = byCategory == nil ? "https://dummyjson.com/products?limit=\(10)&skip=\(0)" : "https://dummyjson.com/products/category/\(byCategory ?? "")"
        guard let url = URL(string: url) else {
            return Fail(error: NetworkingError.invalidURL)
                .eraseToAnyPublisher()
        }
        return NetworkingManger.fetch(url: url)
            .eraseToAnyPublisher()
    }

    func loadMoreItem(limit: Int, skip: Int, byCategory: String?) -> AnyPublisher<ProductsModel, Error> {
        var url = ""
        url = byCategory == nil ? "https://dummyjson.com/products?limit=\(limit)&skip=\(skip)" : "https://dummyjson.com/products/category\(byCategory ?? "")?limit=\(limit)&skip=\(skip)"
        guard let url = URL(string: url) else {
            return Fail(error: NetworkingError.invalidURL)
                .eraseToAnyPublisher()
        }
        return NetworkingManger.fetch(url: url)
            .eraseToAnyPublisher()
    }

    func getProductDetails(productId: Int) -> AnyPublisher<Product, Error> {
        guard let url = URL(string: "https://dummyjson.com/products/\(productId)") else {
            return Fail(error: NetworkingError.invalidURL)
                .eraseToAnyPublisher()
        }
        return NetworkingManger.fetch(url: url)
            .eraseToAnyPublisher()
    }
}
