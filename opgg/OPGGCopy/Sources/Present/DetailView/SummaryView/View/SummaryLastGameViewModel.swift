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
    }
}
