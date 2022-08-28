//
//  BestPlayViewModel.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/25.
//

import Combine
import Foundation

final class BestPlayViewModel: ObservableObject {
    
    class BestPlayData {
        let champId: Int
        let kda: GameSummary
        
        private(set) var playCount = 0
        private(set) var winCount = 0
        private(set) var winRate = WinRate(wins: 0, losses: 0)
        
        init(_ game: GameInfo) {
            self.champId = game.myData.championID
            self.kda = GameSummary(game)
        }
        
        func addPlayCount() {
            playCount += 1
        }
        
        func addWinCount() {
            winCount += 1
        }
        
        func calculation() -> BestPlayData {
            self.winRate = WinRate(wins: winCount, losses: playCount - winCount)
            return self
        }
    }
    
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
    @Inject(\.championData) private var championData: ChampionData
    
    init() {
        let findMostChamp = update.lastGames
            .map {
                $0.reduce(into: [Int: BestPlayData]()) {
                    let prevData = $0[$1.myData.championID] ?? BestPlayData($1)
                    prevData.addPlayCount()
                    if $1.myData.stats.result == .win {
                        prevData.addWinCount()
                    }
                    $0[$1.myData.championID] = prevData
                }
                .map { $0.value.calculation() }
                .sorted(by: { lhs, rhs in
                    if lhs.winRate.rate == rhs.winRate.rate {
                        return lhs.kda.kda > rhs.kda.kda
                    } else {
                        return lhs.winRate.rate > rhs.winRate.rate
                    }
                }).first
            }
            .compactMap { [unowned self] mostChamp -> (Champion, WinRate)? in
                if let mostChamp = mostChamp,
                    let champData = self.championData[mostChamp.champId] {
                    return (champData, mostChamp.winRate)
                } else {
                    return nil
                }
            }
            .share()
        
        findMostChamp
            .compactMap { $0 }
            .sink(receiveValue: { [unowned self] mostChamp, winRate in
                self.state.imageUrl = mostChamp.imageURL
                self.state.name = mostChamp.name
                self.state.winRate = winRate
            })
            .store(in: &cancellable)
    }
}
