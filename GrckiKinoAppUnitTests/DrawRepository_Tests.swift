//
//  DrawRepository_Test.swift
//  GrckiKinoAppTests
//
//  Created by Milena Predic on 18.2.24..
//

import XCTest
@testable import GrckiKinoApp
import Combine

class DrawsRepositoryTests: XCTestCase {
    var repository: DrawsRepository!
    var mockNetworkingService: MockNetworkingService!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockNetworkingService = MockNetworkingService()
        repository = DrawsRepository(networkingService: mockNetworkingService)
        cancellables = []
    }

    func testGetUpcomingDrawsSuccess() {
        let mockDraws: [Draw] = [
            Draw(gameId: 1,
                 drawId: 1,
                 drawTime: Date().timeIntervalSince1970 * 1000 + 3600)
        ]
        mockNetworkingService.mockResponse = mockDraws

        let expectation = XCTestExpectation(description: "Fetch upcoming draws succeeds")

        repository.getUpcommingDraws().sink(receiveCompletion: { _ in }, receiveValue: { draws in
            XCTAssertEqual(draws.count, mockDraws.count)
            expectation.fulfill()
        }).store(in: &cancellables)

        wait(for: [expectation], timeout: 5.0)
    }

    func testGetResultsSuccess() {
        let mockDrawResultsResponse = DrawResultsResponse(content: [DrawResult(gameId: 1,
                                                                               drawId: 1,
                                                                               drawTime: Date().timeIntervalSince1970 * 1000 + 3600,
                                                                               winningNumbers: WinningNumbers(list: [1,2,3],
                                                                                                              bonus: [4]))])
        mockNetworkingService.mockResponse = mockDrawResultsResponse

        let expectation = XCTestExpectation(description: "Fetch draw results succeeds")

        repository.getResults(fromDate: "2023-01-01", toDate: "2023-01-02").sink(receiveCompletion: { _ in }, receiveValue: { results in
            XCTAssertEqual(results.content.count, mockDrawResultsResponse.content.count)
            expectation.fulfill()
        }).store(in: &cancellables)

        wait(for: [expectation], timeout: 5.0)
    }

    override func tearDown() {
        cancellables.forEach { $0.cancel() }
        cancellables = nil
        mockNetworkingService = nil
        repository = nil
        super.tearDown()
    }
}
