//
//  SummaryLastGameViewModel.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/25.
//

import Combine

final class SummaryLastGameViewModel: ObservableObject {
    
    struct State {
        var gameSummary = GameSummary()
        var winRate = WinRate(wins: 0, losses: 0)
    }
    
    struct Update {
        let lastGames = PassthroughSubject<[GameInfo], Never>()
    }
    
    @Published var state = State()
    let update = Update()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        update.lastGames
            .map { GameSummary($0) }
            .sink(receiveValue: { [unowned self] summary in
                state.gameSummary = summary
            })
            .store(in: &cancellable)
        
        update.lastGames
            .map { WinRate($0) }
            .sink(receiveValue: { [unowned self] WinRate in
                state.winRate = WinRate
            })
            .store(in: &cancellable)
    }
}
