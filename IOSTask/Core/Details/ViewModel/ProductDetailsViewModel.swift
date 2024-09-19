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
    @Published var errorMessage: String?

    private let dataService: ProductListDataServiceProtocol
    private var cancellable = Set<AnyCancellable>()

    init(productId: Int, dataService: ProductListDataServiceProtocol) {
        self.dataService = dataService
        getProduct(productId: productId)
    }

    func getProduct(productId: Int) {
        dataService.getProductDetails(productId: productId)
            .sink { [weak self] completion in
                guard let self = self else {return}
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] products in
                guard let self = self else {return}
                self.product = products
            }
            .store(in: &cancellable)
    }
}
