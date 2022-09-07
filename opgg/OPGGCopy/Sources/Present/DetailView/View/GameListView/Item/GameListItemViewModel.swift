//
//  GameListItemViewModel.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/28.
//

import Combine
import Foundation

final class GameListItemViewModel: ObservableObject, Identifiable {
    
    struct State {
        var gameLength = 0
        var gameResult: GameResult = .win
        var gameType: GameType = .normal
        var createAt: Date?
    }
    
    struct Update {
    }
    
    struct ViewModels {
        let summoner: GameItemSummonerViewModel
        let items: SummonerItemsViewModel
    }
    
    let index: Int
    @Published var state = State()
    let update = Update()
    let viewModels: ViewModels
    private var cancellable = Set<AnyCancellable>()
    
    init(index: Int, game: GameInfo) {
        self.index = index
        print(game.myData.stats.isOpscoreMaxInTeam)
        print(game.myData.stats.largestMultiKill)
        print("------------------------")
        let summoner = GameItemSummonerViewModel(game)
        let items = SummonerItemsViewModel(game.myData.items, trinketItem: game.myData.trinketItem)
        
        let myData = game.myData
        viewModels = ViewModels(summoner: summoner, items: items)
        state.gameLength = game.gameLengthSecond
        state.gameResult = myData.stats.result
        
        state.gameType = game.queueInfo.gameType
        state.createAt = game.createdAt
    }
}
