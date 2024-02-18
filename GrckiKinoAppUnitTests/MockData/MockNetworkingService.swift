//
//  MockNetworkingService.swift
//  GrckiKinoAppTests
//
//  Created by Milena Predic on 18.2.24..
//

@testable import GrckiKinoApp
import Foundation
import Combine

class MockNetworkingService: NetworkingServiceProtocol {
    var mockResponse: Any?
    var mockError: APIError?

    func publisherForRequest<Input: Encodable, Response: Decodable>(
        router: NetworkRoutable,
        request: Input? = nil,
        responseType: Response.Type,
        encoder: NetworkParameterEncoder? = nil
    ) -> AnyPublisher<Response, APIError> {
        if let error = mockError {
            return Fail(error: error).eraseToAnyPublisher()
        }

        guard let response = mockResponse as? Response else {
            return Fail(error: APIError.noNetwork("Mock response not set or invalid type")).eraseToAnyPublisher()
        }

        return Just(response)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
}
