//
//  MockDrawRepository.swift
//  GrckiKinoAppTests
//
//  Created by Milena Predic on 18.2.24..
//

@testable import GrckiKinoApp
import Foundation
import Combine

class MockDrawsRepository: DrawsRepositoryProtocol {
    var upcomingDraws: [Draw] = []
    var drawResultsResponse: DrawResultsResponse?
    var error: APIError?

    func getUpcommingDraws() -> AnyPublisher<[Draw], APIError> {
        if let error = error {
            return Fail(error: error).eraseToAnyPublisher()
        }
        return Just(upcomingDraws)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }

    func getResults(fromDate: String, toDate: String) -> AnyPublisher<DrawResultsResponse, APIError> {
        if let error = error {
            return Fail(error: error).eraseToAnyPublisher()
        }
        return Just(drawResultsResponse!)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
}
