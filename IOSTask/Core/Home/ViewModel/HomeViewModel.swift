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
    @Published var product: Product? = nil

    private let productListDataService = ProductListDataService()
    private var cancellable = Set<AnyCancellable>()

    init() {
        addProductDataSubscription()
    }

    func addProductDataSubscription() {
        productListDataService.$products
            .sink(receiveValue: { allProductsResponse  in
                self.productsList = allProductsResponse
            })
            .store(in: &cancellable)
    }
}
