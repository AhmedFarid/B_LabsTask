//
//  ProductDetailsViewModel.swift
//  IOSTask
//
//  Created by Farido on 17/09/2024.
//

import Foundation
import Combine

class ProductDetailsViewModel: ObservableObject {

    @Published var product: Product? = nil

    private let productListDataService: ProductListDataService
    private var cancellable = Set<AnyCancellable>()

    init(productId: Int) {
        self.productListDataService = ProductListDataService()
        getProduct(productId: productId)
        addProductDataSubscription()
    }

    func getProduct(productId: Int) {
        productListDataService.getProductDetails(productId: productId)
    }

    func addProductDataSubscription() {
        productListDataService.$product
            .sink(receiveValue: { productDetailsResponse  in
                self.product = productDetailsResponse
            })
            .store(in: &cancellable)
    }
}
