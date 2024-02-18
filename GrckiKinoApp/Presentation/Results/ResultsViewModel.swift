//
//  ResultsViewModel.swift
//  GrckiKinoApp
//
//  Created by Milena Predic on 14.2.24..
//

import Foundation
import Combine

class ResultsViewModel: ObservableObject {
    private let repository: DrawsRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    @Published var draws: [DrawResult] = []
    
    init(repository: DrawsRepositoryProtocol) {
        self.repository = repository
    }
    
    func getResults(fromDate: String, toDate: String) {
        repository.getResults(fromDate: fromDate, toDate: toDate)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] receivedCompletion in
                switch receivedCompletion {
                case .finished:
                    break
                case .failure(let error):
                    print("API Error: \(error.localizedDescription)")
                    self?.draws = []
                }
            }, receiveValue: { [weak self] response in
                self?.processDraws(draws: response.content)
            })
            .store(in: &cancellables)
    }
    
    func getResultsForToday() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let todayString = dateFormatter.string(from: Date())
        getResults(fromDate: todayString, toDate: todayString)
    }

    private func processDraws(draws: [DrawResult]){
        self.draws = draws.map { draw in
            var draw = draw
            let formattedTimes = DateUtils.formatDrawTime(drawTime: draw.drawTime)
            draw.formattedDrawDate = formattedTimes.date
            draw.formattedDrawTime = formattedTimes.time
            return draw
        }
    }
}
