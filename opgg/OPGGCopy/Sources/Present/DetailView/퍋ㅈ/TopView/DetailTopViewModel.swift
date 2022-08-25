//
//  SummonerInfoViewModel.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/22.
//

import Combine
import Foundation

final class DetailTopViewModel: ObservableObject {
    
    struct State {
        var imageUrl: URL?
        var name = ""
        var rank = ""
    }
    
    struct Update {
        let summonerDetail = PassthroughSubject<SummonerDetail, Never>()
    }
    
    @Published var state = State()
    let update = Update()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        update.summonerDetail
            .map { $0.profileImageURL }
            .sink(receiveValue: { [unowned self] url in
                self.state.imageUrl = url
            })
            .store(in: &cancellable)
        
        update.summonerDetail
            .map { $0.name }
            .sink(receiveValue: { [unowned self] name in
                self.state.name = name
            })
            .store(in: &cancellable)
        
        update.summonerDetail
            .map { $0.ladderRank }
            .map { rank -> String in
                if let rank = rank {
                    return rank.rank.currency()
                } else {
                    return ""
                }
            }
            .sink(receiveValue: { [unowned self] rank in
                self.state.rank = rank
            })
            .store(in: &cancellable)
    }
}
