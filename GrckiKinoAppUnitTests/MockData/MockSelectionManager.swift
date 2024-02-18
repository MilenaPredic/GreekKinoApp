//
//  MockSelectionManager.swift
//  GrckiKinoAppTests
//
//  Created by Milena Predic on 18.2.24..
//

@testable import GrckiKinoApp
import Foundation

class MockSelectionManager: SelectionManagerProtocol {
    var selectedNumbers: Set<Int> = []

    func saveSelection(_ numbers: Set<Int>) {
        selectedNumbers = numbers
    }

    func clearSelection() {
        selectedNumbers.removeAll()
    }
}
