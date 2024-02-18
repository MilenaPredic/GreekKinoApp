//
//  Draw.swift
//  GrckiKinoApp
//
//  Created by Milena Predic on 15.2.24..
//

import Foundation

protocol Drawable: Decodable, Identifiable {
    var gameId: Int { get }
    var drawId: Int { get }
    var drawTime: TimeInterval { get }
    var remainingTime: String? { get set }
    var formattedDrawTime: String? { get set }
}

extension Drawable {
    var id: Int { drawId }
}

struct Draw: Drawable {
    let gameId: Int
    let drawId: Int
    let drawTime: TimeInterval
    var remainingTime: String?
    var formattedDrawTime: String?
}

struct DrawResult: Drawable {
    let gameId: Int
    let drawId: Int
    let drawTime: TimeInterval
    var remainingTime: String?
    var formattedDrawTime: String?
    var formattedDrawDate: String?
    let winningNumbers: WinningNumbers
}

struct WinningNumbers: Decodable {
    let list: [Int]
    let bonus: [Int]
}
