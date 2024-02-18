//
//  DrawsRepository.swift
//  GrckiKinoApp
//
//  Created by Milena Predic on 13.2.24..
//

import Foundation
import Combine
import Alamofire

protocol DrawsRepositoryProtocol {
    func getUpcommingDraws() -> AnyPublisher<[Draw], APIError>
    func getResults(fromDate: String, toDate: String) -> AnyPublisher<DrawResultsResponse, APIError>
}

class DrawsRepository: DrawsRepositoryProtocol {
    private let networkingService: NetworkingServiceProtocol
    
    init(networkingService: NetworkingServiceProtocol) {
        self.networkingService = networkingService
    }
    
    func getUpcommingDraws() -> AnyPublisher<[Draw], APIError> {
        networkingService.publisherForRequest(router: DrawsRouter.getUpcomingDraws,
                                              request: Optional<EmptyRequest>.none,
                                              responseType: [Draw].self,
                                              encoder: NetworkParameterEncoder.json)
        .mapError { error -> APIError in
            return APIError.statusMessage(message: error.localizedDescription)
        }
        .eraseToAnyPublisher()
    }
    
    func getResults(fromDate: String, toDate: String) -> AnyPublisher<DrawResultsResponse, APIError> {
        networkingService.publisherForRequest(router: DrawsRouter.getResults(fromDate: fromDate, 
                                                                             toDate: toDate),
                                              request: Optional<EmptyRequest>.none,
                                              responseType: DrawResultsResponse.self,
                                              encoder: NetworkParameterEncoder.json)
        .mapError { error -> APIError in
            return APIError.statusMessage(message: error.localizedDescription)
        }
        .eraseToAnyPublisher()
    }
}

struct EmptyRequest: Encodable {}
