//
//  MockProductListDataService.swift
//  IOSTask
//
//  Created by Ahmed Farid on 19/09/2024.
//

import Combine

class MockProductListDataService: ProductListDataServiceProtocol {

    let categoryList: [Category]
    let productsModel: ProductsModel
    let product: Product

    init(categoryList: [Category]?, productsModel: ProductsModel? , product: Product?) {
        self.categoryList =  categoryList ?? [
            Category(
                slug: "sadfsa",
                name: "sadasd",
                url: "dasdasd"),
            Category(
                slug: "sdsadsa",
                name: "daseqwe",
                url: "weqwe"),
            Category(
                slug: "sdsadsa",
                name: "daseqwe",
                url: "weqwe"),
            Category(
                slug: "sdsadsa",
                name: "daseqwe",
                url: "weqwe"),
            Category(
                slug: "sdsadsa",
                name: "daseqwe",
                url: "weqwe"),
            Category(
                slug: "sdsadsa",
                name: "daseqwe",
                url: "weqwe")]
        self.productsModel = productsModel ?? ProductsModel(
            products: [
                Product(
                    id: 1,
                    title: "Annibale Colombo Bed",
                    description: "The Annibale Colombo Bed is a luxurious.",
                    sku: "36T6X4M3",
                    category: "furniture", price: 1899.99, discountPercentage: 0.29, rating: 4.14, stock: 47,
                    brand: "Annibale Colombo", thumbnail: "https://cdn.dummyjson.com/products/images/furniture/Annibale%20Colombo%20Bed/thumbnail.png",
                    images: ["https://cdn.dummyjson.com/products/images/womens-watches/Women's%20Wrist%20Watch/1.png",
                             "https://cdn.dummyjson.com/products/images/womens-watches/Women's%20Wrist%20Watch/2.png",
                             "https://cdn.dummyjson.com/products/images/womens-watches/Women's%20Wrist%20Watch/3.png"],
                    availabilityStatus: "In Stock")],
            total: 100, skip: 10, limit: 10)
        self.product = product ?? Product(
            id: 1,
            title: "Annibale Colombo Bed",
            description: "The Annibale Colombo Bed is a luxurious.",
            sku: "36T6X4M3",
            category: "furniture", price: 1899.99, discountPercentage: 0.29, rating: 4.14, stock: 47,
            brand: "Annibale Colombo", thumbnail: "https://cdn.dummyjson.com/products/images/furniture/Annibale%20Colombo%20Bed/thumbnail.png",
            images: ["https://cdn.dummyjson.com/products/images/womens-watches/Women's%20Wrist%20Watch/1.png",
                     "https://cdn.dummyjson.com/products/images/womens-watches/Women's%20Wrist%20Watch/2.png",
                     "https://cdn.dummyjson.com/products/images/womens-watches/Women's%20Wrist%20Watch/3.png"],
            availabilityStatus: "In Stock")
    }

    func getCategories() -> AnyPublisher<[Category], any Error> {
        Just(categoryList)
            .tryMap({$0})
            .eraseToAnyPublisher()
    }

    func getProducts(byCategory: String?) -> AnyPublisher<ProductsModel, any Error> {
            Just(productsModel)
                .tryMap({$0})
                .eraseToAnyPublisher()
    }

    func loadMoreItem(limit: Int, skip: Int, byCategory: String?) -> AnyPublisher<ProductsModel, any Error> {
            Just(productsModel)
                .tryMap({$0})
                .eraseToAnyPublisher()
    }

    func getProductDetails(productId: Int) -> AnyPublisher<Product, any Error> {
            Just(product)
                .tryMap({$0})
                .eraseToAnyPublisher()
    }

}


