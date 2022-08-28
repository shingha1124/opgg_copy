//
//  SummaryViewModel.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/25.
//

import Combine

final class SummaryViewModel: ObservableObject {
    
    struct State {
    }
    
    struct Update {
        let summonerDetail = PassthroughSubject<PageProps, Never>()
    }
    
    struct ViewModels {
        let lastGame = SummaryLastGameViewModel()
        let champScore = ChampScoreViewModel()
        let playedWith = PlayedWithViewModel()
        let bestPlay = BestPlayViewModel()
        let mostChampion = MostChampionViewModel()
    }
    
    @Published var state = State()
    let update = Update()
    let viewModels = ViewModels()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        update.summonerDetail
            .map { $0.games.data }
            .sink(receiveValue: viewModels.lastGame.update.lastGames.send)
            .store(in: &cancellable)
        
        update.summonerDetail
            .compactMap { $0.summoner.mostChampions }
            .sink(receiveValue: viewModels.champScore.update.mostChampion.send)
            .store(in: &cancellable)
        
        update.summonerDetail
            .map { $0.games.data }
            .sink(receiveValue: viewModels.playedWith.update.lastGames.send)
            .store(in: &cancellable)
        
        update.summonerDetail
            .map { $0.games.data }
            .sink(receiveValue: viewModels.bestPlay.update.lastGames.send)
            .store(in: &cancellable)
        
        update.summonerDetail
            .compactMap { $0.summoner.mostChampions }
            .sink(receiveValue: viewModels.mostChampion.update.mostChampion.send)
            .store(in: &cancellable)
    }
}
