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
        var rankType = ""
        var tier = ""
        var lp = 0
        var winRate = WinRate(wins: 0, losses: 0)
    }
    
    @Published var state = State()
    @Inject(\.tierImageData) private var tierImageData: TierImageData
    private var cancellable = Set<AnyCancellable>()
    
    init(_ leagueStats: LeagueStats) {
        if let tier = leagueStats.tierInfo.tier,
           let division = leagueStats.tierInfo.division,
           let lp = leagueStats.tierInfo.lp {
            state.tierImageUrl = tierImageData[tier]?.tierImageURL
            state.tier = "\(tier.name) \(division)"
            state.lp = lp
        } else {
            state.tier = "Unranked"
        }
        
        state.rankType = leagueStats.queueInfo.queueTranslate
        state.winRate = WinRate(wins: leagueStats.win, losses: leagueStats.lose)
    }
}
