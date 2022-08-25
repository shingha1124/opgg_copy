//
//  SearchSummonerCellView.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/22.
//

import Combine
import Foundation.NSURL

final class SearchSummonerCellViewModel: ObservableObject, Identifiable {
    struct Action {
        let tappedItem = PassthroughSubject<Void, Never>()
    }
    
    struct State {
        let summoner: SearchSummoner
        var profileImageURL: URL?
        var name = ""
        var tierText = ""
        var summonerId = ""
        var internalName = ""
        let presentDetail = PassthroughSubject<SearchSummoner, Never>()
    }
    
    @Published var state: State
    let action = Action()
    private var cancellable = Set<AnyCancellable>()
    
    init(_ summoner: SearchSummoner) {
        self.state = State(summoner: summoner)
        state.profileImageURL = summoner.profileImageURL
        state.name = summoner.name
        state.summonerId = summoner.summonerID
        state.internalName = summoner.internalName
        
        if let tierInfo = summoner.soloTierInfo {
            state.tierText = "\(tierInfo.tier.name) \(tierInfo.division) - \(tierInfo.lp)LP"
        } else {
            state.tierText = "Level \(summoner.level)"
        }
        
        action.tappedItem
            .map { summoner }
            .sink(receiveValue: state.presentDetail.send)
            .store(in: &cancellable)
    }
}
