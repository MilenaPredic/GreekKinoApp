//
//  NetworkParameterEncoder.swift
//  GrckiKinoApp
//
//  Created by Milena Predic on 12.2.24..
//

import Foundation
import Alamofire

enum NetworkParameterEncoder {
    case url
    case json
}

private extension NetworkParameterEncoder {
    var encoder: ParameterEncoder {
        switch self {
        case .url:
            return URLEncodedFormParameterEncoder.default
            
        case .json:
            return JSONParameterEncoder.default
        }
    }
}

extension NetworkParameterEncoder {
    
    static func getDefaultEncoder() -> ParameterEncoder {
        return url.encoder
    }
    
    func getEncoder() -> ParameterEncoder {
        return encoder
    }
}
