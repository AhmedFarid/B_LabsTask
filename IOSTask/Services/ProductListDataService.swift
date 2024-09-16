//
//  ProductListDataService.swift
//  IOSTask
//
//  Created by Farido on 16/09/2024.
//

import Foundation
import Combine

class ProductListDataService {
    @Published var products: [Product] = []
    @Published var category: [Category] = []
    @Published var product: Product?

    @Published var isLoading = false
    @Published var hasMoreData = true
    private var skip = 10
    private let limit = 10
    private var total = 0

    var productSubscription: AnyCancellable?
    var categorySubscription: AnyCancellable?
    var productDetailsSubscription: AnyCancellable?

    init() {
        getProducts(byCategory: nil)
        getCategories()
    }

    func getCategories() {
        guard let url = URL(string: "https://dummyjson.com/products/categories") else {return}
        categorySubscription = NetworkingManger.download(url: url)
            .decode(type: [Category].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManger.handleCompletion, receiveValue: { [weak self] categoryResponse in
                guard let self = self else {return}
                self.category = categoryResponse
                self.categorySubscription?.cancel()
            })
    }

    func getProducts(byCategory: String?) {
        var url = ""
        url = byCategory == nil ? "https://dummyjson.com/products?limit=\(limit)&skip=\(skip)" : "https://dummyjson.com/products/category/\(byCategory ?? "")"
        guard let url = URL(string: url) else {return}
        productSubscription = NetworkingManger.download(url: url)
            .decode(type: ProductsModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManger.handleCompletion, receiveValue: { [weak self] productResponse in
                guard let self = self else {return}
                self.products = productResponse.products ?? []
                self.total = productResponse.total ?? 0
                checkHaveMoreData()
                self.productSubscription?.cancel()
            })
    }

    func loadMoreItem() {
        guard !isLoading && hasMoreData else {return}

        isLoading = true

        guard let url = URL(string: "https://dummyjson.com/products?limit=\(limit)&skip=\(skip)") else {return}
        productSubscription = NetworkingManger.download(url: url)
            .decode(type: ProductsModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManger.handleCompletion, receiveValue: { [weak self] productResponse in
                guard let self = self else {return}
                self.products.append(contentsOf: productResponse.products ?? [])
                self.total = productResponse.total ?? 0
                self.productSubscription?.cancel()
            })

        self.skip += self.limit

        checkHaveMoreData()

        self.isLoading = false
    }

    func checkHaveMoreData() {
        if self.skip >= self.total {
            self.hasMoreData = false
        }
    }

    func getProductDetails(productId: Int) {
        guard let url = URL(string: "https://dummyjson.com/products/\(productId)") else {return}
        productDetailsSubscription = NetworkingManger.download(url: url)
            .decode(type: Product.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManger.handleCompletion, receiveValue: { [weak self] productResponse in
                guard let self = self else {return}
                self.product = productResponse
                self.productDetailsSubscription?.cancel()
            })
    }
}
