//
//  HomeViewModel_Test.swift
//  IOSTaskTests
//
//  Created by Farido on 20/09/2024.
//

import XCTest
import Combine
@testable import IOSTask

final class HomeViewModel_Test: XCTestCase {

    private var homeViewModel: HomeViewModel!
    private var dataService: ProductListDataServiceClient!
    private var cancellable = Set<AnyCancellable>()

    private var filename = "categories"

    override func setUp() {
        super.setUp()
        dataService = ProductListDataServiceClient(filename: filename)
        homeViewModel = HomeViewModel(dataService: dataService)
    }

    override func tearDown() {
        homeViewModel = nil
        dataService = nil
        super.tearDown()
    }

    func testFetchProducts_DecodesJSONFileCorrectly() {
        let expectation = XCTestExpectation(description: "Fetch products and decode JSON")
        dataService.getCategories()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTFail("Error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { category in
                XCTAssertEqual(category.count, 1, "Expected to decode 1 products.")
                XCTAssertEqual(category[0].name ?? "", "Beauty")
                expectation.fulfill()
            })
            .store(in: &cancellable)

        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 1.0)
    }
}
