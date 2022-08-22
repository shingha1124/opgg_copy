//
//  SearchSummonerCellView.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/22.
//

import Combine
import Foundation

final class SearchSummonerCellViewModel: ObservableObject, Identifiable {
        
    struct State {
        var profileImageURL: URL?
        var name = ""
        var tierText = ""
        var summonerId = ""
    }
    
    @Published var state = State()
    private var cancellable = Set<AnyCancellable>()
    
    init(_ summoner: SearchSummoner) {
        state.profileImageURL = summoner.profileImageURL
        state.name = summoner.name
        state.summonerId = summoner.summonerID
        
        if let tierInfo = summoner.soloTierInfo {
            state.tierText = "\(tierInfo.tier.name) \(tierInfo.division) - \(tierInfo.lp)LP"
        } else {
            state.tierText = "Level \(summoner.level)"
        }
    }
}
