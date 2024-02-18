//
//  StockViewModel.swift
//  GrckiKinoApp
//
//  Created by Milena Predic on 15.2.24..
//

import Foundation

class StockViewModel: ObservableObject {
    @Published var selectedNumbers: Set<Int> = []
    @Published var maxSelection: Int = 1
    let maxNumberLimit = 15
    
    private var selectionManager: SelectionManagerProtocol

    init(selectionManager: SelectionManagerProtocol = SelectionManager.shared) {
        self.selectionManager = selectionManager
    }

    func generateRandomSelections() {
        selectionManager.clearSelection()
        while selectionManager.selectedNumbers.count < maxSelection {
            let randomNumber = Int.random(in: 1...80)
            selectionManager.selectedNumbers.insert(randomNumber)
        }
        selectedNumbers = selectionManager.selectedNumbers
    }

    func toggleNumber(_ number: Int) {
        if selectionManager.selectedNumbers.contains(number) {
            selectionManager.selectedNumbers.remove(number)
        } else if selectionManager.selectedNumbers.count < maxSelection {
            selectionManager.selectedNumbers.insert(number)
        }
        selectedNumbers = selectionManager.selectedNumbers
    }
}
