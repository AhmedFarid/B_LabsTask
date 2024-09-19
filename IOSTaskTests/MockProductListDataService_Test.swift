//
//  MockProductListDataService_Test.swift
//  IOSTaskTests
//
//  Created by Farido on 20/09/2024.
//

import XCTest
import Combine
@testable import IOSTask

final class MockProductListDataService_Test: XCTestCase {

    var cancellable = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_NewMockDataService_init_setValuesCorrectly() {
        // Given
        let item: [CategoryModel]? = nil
        let item2: [CategoryModel]? = []
        let item3: [CategoryModel]? = [CategoryModel(slug: "slug1", name: "name1", url: "url1"), CategoryModel(slug: "slug2", name: "name2", url: "url2"), CategoryModel(slug: "slug3", name: "name3", url: "url3")]

        // When
        let dataService = MockProductListDataService(categoryList: item, productsModel: nil, product: nil)
        let dataService2 = MockProductListDataService(categoryList: item2, productsModel: nil, product: nil)
        let dataService3 = MockProductListDataService(categoryList: item3, productsModel: nil, product: nil)

        // Then
        XCTAssertFalse(dataService.categoryList.isEmpty)
        XCTAssertTrue(dataService2.categoryList.isEmpty)
        XCTAssertEqual(dataService3.categoryList.count, 3)
    }

    func test_NewMockDataService_downloadItems_getCategory_doseReturnValues() {
        // Given
        let dataService = MockProductListDataService(categoryList: nil, productsModel: nil, product: nil)

        // When
        var items: [CategoryModel] = []
        let expectation = XCTestExpectation()
        dataService.getCategories()
            .sink { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case.failure:
                    XCTFail()
                }
            } receiveValue: { returnedItem in
                items = returnedItem
            }
            .store(in: &cancellable)
    
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(items.count, dataService.categoryList.count)
    }

    
    func test_NewMockDataService_downloadItems_getCategory_doseFail() {
        // Given
        let dataService = MockProductListDataService(categoryList: [], productsModel: nil, product: nil)

        // When
        var items: [CategoryModel] = []
        let expectation = XCTestExpectation(description: "Dose throw an error")
        let expectation2 = XCTestExpectation(description: "Dose throw URLError badServerResponse")

        dataService.getCategories()
            .sink { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case.failure(let error):
                    expectation.fulfill()
                    let urlError = error as? URLError
                    XCTAssertEqual(urlError, URLError(.badServerResponse))
    
                    if urlError == URLError(.badServerResponse) {
                        expectation2.fulfill()
                    }
                }
            } receiveValue: { returnedItem in
                items = returnedItem
            }
            .store(in: &cancellable)
    
        // Then
        wait(for: [expectation], timeout: 30)
        XCTAssertEqual(items.count, dataService.categoryList.count)

    }
}
