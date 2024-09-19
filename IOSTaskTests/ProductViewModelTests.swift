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

    var viewModel: HomeViewModel?
    var mockDataService :MockProductListDataService?
    var cancellable = Set<AnyCancellable>()


    override func setUp() {
        super.setUp()
        dataService = MockProductListDataService()
        viewModel = HomeViewModel(dataService: dataService)
    }

    override func tearDown() {
        viewModel = nil
        dataService = nil
        cancellable.removeAll()
        super.tearDown()
    }



}
