//
//  ProductListViewModel_Tests.swift
//  IOSTaskTests
//
//  Created by Farido on 17/09/2024.
//

import XCTest
@testable import IOSTask
import Combine

final class ProductListViewModel_Tests: XCTestCase {

    var viewModel: HomeViewModel!
    var mockDataService :MockProductListDataService!
    var cancellable = Set<AnyCancellable>()


    override func setUp() {
        super.setUp()
        mockDataService = MockProductListDataService(categoryList: nil, productsModel: nil, product: nil)
        viewModel = HomeViewModel(dataService: mockDataService)
    }

    override func tearDown() {
        viewModel = nil
        mockDataService = nil
        cancellable.removeAll()
        super.tearDown()
    }


    func test_ProductListViewModel_getCategory_shouldReturnItems() {
        // Given VM
        let items: [CategoryModel] = [CategoryModel(slug: "slug1", name: "name1", url: "url1"), CategoryModel(slug: "slug2", name: "name2", url: "url2"), CategoryModel(slug: "slug3", name: "name3", url: "url3")]
        let dataServices: ProductListDataServiceProtocol = MockProductListDataService(categoryList: items, productsModel: nil, product: nil)
        viewModel = HomeViewModel(dataService: dataServices)

        // when call getCategory
        let expectation = XCTestExpectation(description: "Should return item after a seconds")
        viewModel.$category
            .dropFirst()
            .sink { items in
                expectation.fulfill()
            }.store(in: &cancellable)
        viewModel.getCategory()

        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(viewModel.category.count, 0)
        XCTAssertEqual(viewModel.category.count, items.count)
    }


    func test_ProductListViewModel_getProduct_shouldReturnItems() {
        // Given VM

        // when call getCategory
        let expectation = XCTestExpectation(description: "Should return item after a seconds")
        viewModel.$productsList
            .dropFirst()
            .sink { items in
                expectation.fulfill()
            }.store(in: &cancellable)
        viewModel.getProduct(byCategory: "")

        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(viewModel.productsList.count, 0)
        XCTAssertEqual(viewModel.productsList.count, mockDataService.productsModel.products?.count)
    }
}
