//
//  SelectionManager.swift
//  GrckiKinoApp
//
//  Created by Milena Predic on 18.2.24..
//

import Foundation

protocol SelectionManagerProtocol {
    var selectedNumbers: Set<Int> { get set }
    func saveSelection(_ numbers: Set<Int>)
    func clearSelection()
}

class SelectionManager: SelectionManagerProtocol {
    static let shared = SelectionManager()
    private init() {}

    var selectedNumbers: Set<Int> = []

    func saveSelection(_ numbers: Set<Int>) {
        selectedNumbers = numbers
    }

    func clearSelection() {
        selectedNumbers.removeAll()
    }
}
