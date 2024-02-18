//
//  Draw.swift
//  GrckiKinoApp
//
//  Created by Milena Predic on 12.2.24..
//

import Foundation

struct UpcomingDrawResponse: Decodable {
    let draws: [Draw]
}

struct DrawResultsResponse: Decodable {
    let content: [DrawResult]
}
