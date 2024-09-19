//
//  HomeViewModel.swift
//  IOSTask
//
//  Created by Farido on 16/09/2024.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {

    private let dataService: ProductListDataServiceProtocol
    private var cancellable = Set<AnyCancellable>()

    @Published var productsList: [Product] = []
    @Published var category: [CategoryModel] = []
    @Published var selectedCategory: CategoryModel? = nil
    @Published var errorMessage: String?


    @Published var isLoading = false
    @Published var hasMoreData = true
    private var skip = 10
    private let limit = 10
    private var total = 0

    init(dataService: ProductListDataServiceProtocol) {
        self.dataService = dataService
        getCategory()
        getProduct(byCategory: nil)
    }

    func getCategory()  {
        dataService.getCategories()
            .sink { [weak self] completion in
                guard let self = self else {return}
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] category in
                guard let self = self else {return}
                self.category = category
            }
            .store(in: &cancellable)
    }

    func getProduct(byCategory: String?) {
        dataService.getProducts(byCategory: byCategory)
            .sink { [weak self] completion in
                guard let self = self else {return}
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] product in
                guard let self = self else {return}
                self.productsList = product.products ?? []
                checkHaveMoreData(total: product.total ?? 0)
            }
            .store(in: &cancellable)
    }

    func getMoreData() {
        guard !isLoading && hasMoreData else {return}
        isLoading = true
        
        dataService.loadMoreItem(limit: limit, skip: skip, byCategory: selectedCategory?.slug)
            .sink { [weak self] completion in
                guard let self = self else {return}
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] product in
                guard let self = self else {return}
                self.productsList.append(contentsOf: product.products ?? [])
                checkHaveMoreData(total: product.total ?? 0)
            }
            .store(in: &cancellable)
    }

    func checkHaveMoreData(total: Int) {
        self.total = total
        self.skip += self.limit
        if self.skip >= self.total {
            self.hasMoreData = false
        }
        self.isLoading = false
    }
}
