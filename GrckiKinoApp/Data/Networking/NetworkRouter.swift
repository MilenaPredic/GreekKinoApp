//
//  NetworkRouter.swift
//  GrckiKinoApp
//
//  Created by Milena Predic on 12.2.24..
//

import Alamofire
import Foundation

protocol NetworkRoutable {
    var headers: HTTPHeaders? { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var url: String { get }
    var encoder: NetworkParameterEncoder { get }
}

enum DrawsRouter: NetworkRoutable {
    case getUpcomingDraws
    case getResults(fromDate: String, toDate: String)
    
    var headers: HTTPHeaders? {
        switch self {
        case .getResults, .getUpcomingDraws:
            return ["Accept": "application/json"]
        }
    }
    
    var url: String {
        switch self {
        case .getResults, .getUpcomingDraws:
            return APIConstants.baseURL + path
        }
    }
    
    var encoder: NetworkParameterEncoder {
        switch self {
        case .getResults, .getUpcomingDraws:
            return .json
        }
    }
    
    var path: String {
        switch self {
        case .getUpcomingDraws:
            return "v3.0/1100/upcoming/20"
        case .getResults(let fromDate,let toDate):
            return "v3.0/1100/draw-date/\(fromDate)/\(toDate)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getResults, .getUpcomingDraws:
            return .get
        }
    }
}
