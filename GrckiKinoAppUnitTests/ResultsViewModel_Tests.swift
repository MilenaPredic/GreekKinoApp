//
//  ResultsViewModel_Tests.swift
//  GrckiKinoAppTests
//
//  Created by Milena Predic on 18.2.24..
//

import XCTest
@testable import GrckiKinoApp
import Combine

class ResultsViewModelTests: XCTestCase {
    var viewModel: ResultsViewModel!
    var mockRepository: MockDrawsRepository!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockRepository = MockDrawsRepository()
        viewModel = ResultsViewModel(repository: mockRepository)
        cancellables = []
    }

    func testGetResultsForTodaySuccess() {
        let mockDrawResults = [DrawResult(gameId: 1,
                                          drawId: 1,
                                          drawTime: Date().timeIntervalSince1970,
                                          winningNumbers: WinningNumbers(list: [1,2,3],
                                                                         bonus: [4]))]
        mockRepository.drawResultsResponse = DrawResultsResponse(content: mockDrawResults)

        let expectation = self.expectation(description: "Fetch results for today")

        viewModel.$draws
            .dropFirst()
            .sink { draws in
                XCTAssertEqual(draws.count, mockDrawResults.count)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.getResultsForToday()

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        cancellables.forEach { $0.cancel() }
        cancellables = nil
        super.tearDown()
    }
}

