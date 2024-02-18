//
//  UpcomingDrawsViewModel_Tests.swift
//  GrckiKinoAppTests
//
//  Created by Milena Predic on 18.2.24..
//

import XCTest
@testable import GrckiKinoApp
import Combine

class UpcomingDrawsViewModelTests: XCTestCase {
    var viewModel: UpcomingDrawsViewModel!
    var mockRepository: MockDrawsRepository!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockRepository = MockDrawsRepository()
        viewModel = UpcomingDrawsViewModel(repository: mockRepository)
        cancellables = []
    }

    func testGetUpcomingDrawsSuccess() {
        mockRepository.upcomingDraws = [Draw(gameId: 1,
                                             drawId: 1,
                                             drawTime: Date().timeIntervalSince1970 * 1000 + 3600)]
        let expectation = XCTestExpectation(description: "Successfully fetched upcoming draws")

        viewModel.$draws
            .dropFirst()
            .sink { draws in
                XCTAssertEqual(draws.count, 1)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.getUpcomingDraws()
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testUpdateSelectedDraw() {
        let mockDraws = [Draw(gameId: 1,
                              drawId: 1,
                              drawTime: Date().timeIntervalSince1970 * 1000 + 5000)]
        mockRepository.upcomingDraws = mockDraws
        
        viewModel.getUpcomingDraws()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertNotNil(self.viewModel.selectedDraw)
        }
    }

    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        cancellables.forEach { $0.cancel() }
        cancellables = nil
        super.tearDown()
    }
}
