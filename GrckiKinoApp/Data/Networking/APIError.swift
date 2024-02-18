//
//  APIError.swift
//  GrckiKinoApp
//
//  Created by Milena Predic on 12.2.24..
//

import Foundation

enum APIError : Error {
    case noData
    case noNetwork(String)
    case unknownError
    case serverError
    case statusMessage(message : String)
    case decodeError(String)
}

extension APIError {
    var desc: String {
        switch self {
        case .noData:                     return MessageHelper.serverError.notFound
        case .noNetwork(let error):                  return error
        case .unknownError:               return MessageHelper.serverError.general
        case .serverError:                return MessageHelper.serverError.serverError
        case .statusMessage(let message): return message
        case .decodeError(let error):     return error
        }
    }
}

struct MessageHelper {
    struct serverError {
        static let general : String = "Bad Request"
        static let noInternet : String = "Check the Connection"
        static let timeOut : String = "Timeout"
        static let notFound : String = "No Result"
        static let serverError : String = "Internal Server Error"
    }
}
