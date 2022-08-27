//
//  ChampScoreView.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/25.
//

import Combine
import Foundation

final class ChampScoreViewModel: ObservableObject {
    
    struct State {
        var champImageUrl: URL?
        var champName = ""
        var playCount = 0
    }
    
    struct Update {
        let mostChampion = PassthroughSubject<MostChampions, Never>()
    }
    
    @Published var state = State()
    let update = Update()
    private var cancellable = Set<AnyCancellable>()
    
    @Inject(\.championData) private var championData: ChampionData
    
    init() {
        update.mostChampion
            .compactMap { $0.championStats.first?[.play] }
            .sink(receiveValue: { [unowned self] play in
                self.state.playCount = play
            })
            .store(in: &cancellable)
        
        let findDBChamp = update.mostChampion
            .compactMap { $0.championStats.first?[.id] }
            .compactMap { [unowned self] champId in
                self.championData[champId]
            }
            .share()
        
        findDBChamp
            .map { $0.imageURL }
            .sink(receiveValue: { [unowned self] champImageUrl in
                self.state.champImageUrl = champImageUrl
            })
            .store(in: &cancellable)
        
        findDBChamp
            .map { $0.name }
            .sink(receiveValue: { [unowned self] name in
                self.state.champName = name
            })
            .store(in: &cancellable)
    }
}
