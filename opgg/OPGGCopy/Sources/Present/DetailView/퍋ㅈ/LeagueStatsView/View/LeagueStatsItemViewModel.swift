//
//  LeagueStatsItemViewModel.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/22.
//

import Combine
import Foundation

final class LeagueStatsItemViewModel: ObservableObject, Identifiable {
    
    struct State {
        var tierImageUrl: URL?
    }
    
    @Published var state = State()
    private var cancellable = Set<AnyCancellable>()
    
    init(_ leagueStats: LeagueStats) {
        print(leagueStats)
        state.tierImageUrl = leagueStats.tierInfo.tierImageURL
    }
}

