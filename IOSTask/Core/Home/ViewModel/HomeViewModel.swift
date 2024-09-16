//
//  HomeViewModel.swift
//  IOSTask
//
//  Created by Farido on 16/09/2024.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {

    @Published var productsList: [Product] = []
    @Published var category: [Category] = []
    @Published var selectedCategory: Category? = nil
    @Published var isLoading = false
    @Published var error: Error? = nil

    private let productListDataService: ProductListDataService
    private var cancellable = Set<AnyCancellable>()

    init() {
        self.productListDataService = ProductListDataService()
        addProductDataSubscription()
        addCategoryDataSubscription()
    }

    func addCategoryDataSubscription()  {
        productListDataService.$category
            .sink { category in
                self.category = category
            }
            .store(in: &cancellable)
    }

    func addProductDataSubscription() {
        productListDataService.$products
            .sink(receiveValue: { allProductsResponse  in
                self.productsList = allProductsResponse
            })
            .store(in: &cancellable)
    }

    func getProduct(byCategory: String) {
        productListDataService.getProducts(byCategory: byCategory)
    }

    func getMoreData() {
        productListDataService.loadMoreItem()
    }
}
