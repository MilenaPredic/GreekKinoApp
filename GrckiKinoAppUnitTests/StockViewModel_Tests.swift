//
//  StockViewModel_Tests.swift
//  GrckiKinoAppTests
//
//  Created by Milena Predic on 18.2.24..
//

import XCTest
@testable import GrckiKinoApp

class StockViewModelTests: XCTestCase {
    var viewModel: StockViewModel!
    var mockSelectionManager: MockSelectionManager!

    override func setUp() {
        super.setUp()
        mockSelectionManager = MockSelectionManager()
        viewModel = StockViewModel(selectionManager: mockSelectionManager)
    }
    
    func testGenerateRandomSelections() {
        viewModel.maxSelection = 5
        viewModel.generateRandomSelections()
        XCTAssertEqual(viewModel.selectedNumbers.count, 5)
        XCTAssertTrue(viewModel.selectedNumbers.allSatisfy { $0 >= 1 && $0 <= 80 })
    }

    func testToggleNumber() {
        viewModel.maxSelection = 5
        viewModel.toggleNumber(10)
        XCTAssertTrue(viewModel.selectedNumbers.contains(10), "Number 10 should be selected")

        viewModel.toggleNumber(10)
        XCTAssertFalse(viewModel.selectedNumbers.contains(10), "Number 10 should be selected")
    }


    override func tearDown() {
        viewModel = nil
        mockSelectionManager = nil
        super.tearDown()
    }
}
