//
//  ProductImageViewModel.swift
//  IOSTask
//
//  Created by Farido on 16/09/2024.
//

import Foundation
import SwiftUI
import Combine

class ProductImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false

    private let dataService: ProductImageServices
    private var cancellable = Set<AnyCancellable>()

    init(url: String) {
        self.dataService = ProductImageServices(url: url)
        self.addSubscribers()
        self.isLoading = true
    }

    private func addSubscribers() {
        dataService.$image
            .sink {[weak self] (_) in
                guard let self = self else {return}
                self.isLoading = false
            } receiveValue: {[weak self] returnedImage  in
                guard let self = self else {return}
                self.image = returnedImage
            }
            .store(in: &cancellable)
    }
}
