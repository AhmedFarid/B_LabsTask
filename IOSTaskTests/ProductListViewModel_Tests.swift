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

        // when call getCategory
        let expectation = XCTestExpectation()
        mockDataService.getCategories()
            .sink { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case.failure:
                    XCTFail()
                }
            } receiveValue: { [weak self] returnedItem in
                self?.viewModel.category = returnedItem
            }
            .store(in: &cancellable)

        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(viewModel.category.count, 5)
    }

}
