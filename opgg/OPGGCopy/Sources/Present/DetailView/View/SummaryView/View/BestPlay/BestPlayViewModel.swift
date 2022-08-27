//
//  BestPlayViewModel.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/25.
//

import Combine
import Foundation

final class BestPlayViewModel: ObservableObject {
    
    struct State {
        var imageUrl: URL?
        var name = ""
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
            .sink(receiveValue: { [unowned self] summary in
//                state.gameSummary = summary
            })
            .store(in: &cancellable)
    }
}
