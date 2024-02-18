//
//  UpcomingDrawsViewModel.swift
//  GrckiKinoApp
//
//  Created by Milena Predic on 18.2.24..
//

import Foundation
import Combine

class UpcomingDrawsViewModel: ObservableObject {
    private let repository: DrawsRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    @Published var selectedDraw: Draw?
    private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let currentTime = Date().timeIntervalSince1970 * 1000
    
    @Published var draws: [Draw] = [] {
        didSet {
            if selectedDraw == nil || (selectedDraw?.drawTime ?? 0) < Date().timeIntervalSince1970 * 1000 {
                updateSelectedDraw()
            }
        }
    }
    
    init(repository: DrawsRepositoryProtocol) {
        self.repository = repository
        setupTimer()
    }
    
    deinit {
        timer.upstream.connect().cancel()
    }
    
    func getUpcomingDraws() {
        repository.getUpcommingDraws()
            .map { draws in
                draws.map { draw in
                    var draw = draw
                    draw.formattedDrawTime = DateUtils.formatTimestamp(draw.drawTime)
                    return draw
                }
            }
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
                self?.draws = response
            })
            .store(in: &cancellables)
    }
    
    private func setupTimer() {
        timer
            .sink { [weak self] _ in
                self?.updateRemainingTimeForDraws()
            }
            .store(in: &cancellables)
    }
    
    private func updateRemainingTimeForDraws() {
        let currentTime = Date().timeIntervalSince1970

        self.draws = self.draws.compactMap { draw in
            var newDraw = draw
            newDraw.remainingTime = DateUtils.timeRemainingUntilDraw(drawTime: draw.drawTime)

            if draw.drawTime / 1000 > currentTime {
                return newDraw
            } else {
                return nil
            }
        }
    }
    
    func updateSelectedDraw() {
        if let nextDraw = draws.first(where: { $0.drawTime > currentTime }) {
            selectedDraw = nextDraw
        } else {
            selectedDraw = nil
        }
    }
}
