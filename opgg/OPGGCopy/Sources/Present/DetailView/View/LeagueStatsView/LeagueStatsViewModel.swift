//
//  LeagueStatsViewModel.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/22.
//

import Combine

final class LeagueStatsViewModel: ObservableObject {
    
    struct State {
        var items = [LeagueStatsItemViewModel]()
    }
    
    struct Update {
        let leagueStats = PassthroughSubject<[LeagueStats], Never>()
    }
    
    @Published var state = State()
    let update = Update()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        update.leagueStats
            .map { $0.map { LeagueStatsItemViewModel($0) } }
            .sink(receiveValue: { [unowned self] items in
                self.state.items = items
            })
            .store(in: &cancellable)
    }
}
