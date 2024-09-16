//
//  ProductViewModelTests.swift
//  IOSTaskTests
//
//  Created by Farido on 17/09/2024.
//

import XCTest
@testable import IOSTask
import Combine

final class ProductViewModelTests: XCTestCase {

    var viewModel: HomeViewModel!
    private var mockService: MockProductListDataService!
    private var cancellables = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        mockService = MockProductListDataService()
        viewModel = HomeViewModel()
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        cancellables.removeAll()
        super.tearDown()
    }

    func testFetchProductsSuccess() {
            mockService.products = [Product(id: 1, title: "Annibale Colombo Bed", description: "The Annibale Colombo Bed is a luxurious and elegant bed frame, crafted with high-quality materials for a comfortable and stylish bedroom.", sku: "36T6X4M3", category: "furniture", price: 1899.99, discountPercentage: 0.29, rating: 4.14, stock: 47, brand: "Annibale Colombo", thumbnail: "https://cdn.dummyjson.com/products/images/furniture/Annibale%20Colombo%20Bed/thumbnail.png", images: [
                 "https://cdn.dummyjson.com/products/images/womens-watches/Women's%20Wrist%20Watch/3.png"], availabilityStatus: "In Stock")]

            let expectation = self.expectation(description: "Products should be fetched")
            viewModel.$productsList
                .dropFirst()
                .sink { products in
                    XCTAssertEqual(products, [Product(id: 1, title: "Annibale Colombo Bed", description: "The Annibale Colombo Bed is a luxurious and elegant bed frame, crafted with high-quality materials for a comfortable and stylish bedroom.", sku: "36T6X4M3", category: "furniture", price: 1899.99, discountPercentage: 0.29, rating: 4.14, stock: 47, brand: "Annibale Colombo", thumbnail: "https://cdn.dummyjson.com/products/images/furniture/Annibale%20Colombo%20Bed/thumbnail.png", images: [
                        "https://cdn.dummyjson.com/products/images/womens-watches/Women's%20Wrist%20Watch/3.png"], availabilityStatus: "In Stock")])
                    expectation.fulfill()
                }
                .store(in: &cancellables)

            // Wait
            waitForExpectations(timeout: 1.0, handler: nil)
        }

        func testFetchProductsFailure() {
            let expectedError = NSError(domain: "", code: -1, userInfo: nil)
            mockService.error = expectedError

            let expectation = self.expectation(description: "Products should not be fetched due to error")
            viewModel.$error
                .dropFirst()
                .sink { error in
                    XCTAssertEqual(error as NSError?, expectedError)
                    expectation.fulfill()
                }
                .store(in: &cancellables)

            // Wait
            waitForExpectations(timeout: 1.0, handler: nil)
        }
}
