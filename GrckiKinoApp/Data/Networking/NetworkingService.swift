//
//  NetworkingService.swift
//  GrckiKinoApp
//
//  Created by Milena Predic on 12.2.24..
//

import Combine
import Foundation
import Alamofire

protocol NetworkingServiceProtocol {
    func publisherForRequest<Input: Encodable, Response: Decodable>(
        router: NetworkRoutable,
        request: Input?,
        responseType: Response.Type,
        encoder: NetworkParameterEncoder?
    ) -> AnyPublisher<Response, APIError>
}

class NetworkingService: NetworkingServiceProtocol {
    private let session: Session
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        self.session = Session(configuration: configuration)
    }
    
    func publisherForRequest<Input: Encodable, Response: Decodable>(router: NetworkRoutable,
                                                                    request: Input? = nil,
                                                                    responseType: Response.Type,
                                                                    encoder: NetworkParameterEncoder? = nil)
                                                                            -> AnyPublisher<Response, APIError> {
        let encoder = encoder?.getEncoder() ?? NetworkParameterEncoder.getDefaultEncoder()
        return session
            .request(
                router.url,
                method: router.method,
                parameters: request,
                encoder: encoder,
                headers: router.headers)
            .validate()
            .publishDecodable(type: Response.self)
            .value()
            .mapError { error -> APIError in
                return APIError.noNetwork(error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
}
