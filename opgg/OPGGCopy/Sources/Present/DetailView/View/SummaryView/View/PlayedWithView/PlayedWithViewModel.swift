//
//  PlayedWithViewModel.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/25.
//

import Combine
import Foundation

final class PlayedWithViewModel: ObservableObject {
    
    struct State {
        var profileImageURL: URL?
        var name = ""
        var winRate = WinRate(wins: 0, losses: 0)
    }
    
    struct Update {
        let lastGames = PassthroughSubject<[GameInfo], Never>()
    }
    
    @Published var state = State()
    let update = Update()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        update.lastGames
            .map { $0.flatMap { $0.participants.map { ($0.summoner, $0.stats.result == .win) } } }
            .compactMap { summoners -> (url: URL, name: String, winRate: WinRate)? in
                var withCount = [String: Int]()
                var winCount = [String: Int]()
                
                summoners.forEach { summoner in
                    let prevWithCount = withCount[summoner.0.name] ?? 0
                    withCount[summoner.0.name] = prevWithCount + 1
                    
                    let prevWinCount = winCount[summoner.0.name] ?? 0
                    winCount[summoner.0.name] = prevWinCount + (summoner.1 ? 1 : 0)
                }
                                
                guard let mostWithPlayer = withCount.sorted(by: { $0.value > $1.value }).dropFirst().first,
                      let mostWinCount = winCount[mostWithPlayer.key],
                      let summoner = summoners.first(where: { $0.0.name == mostWithPlayer.key }) else {
                    return nil
                }
                let winRate = WinRate(wins: mostWinCount, losses: mostWithPlayer.value - mostWinCount)
                
                return (url: summoner.0.profileImageURL, name: summoner.0.name, winRate: winRate)
            }
            .sink(receiveValue: { [unowned self] result in
                self.state.profileImageURL = result.url
                self.state.name = result.name
                self.state.winRate = result.winRate
            })
            .store(in: &cancellable)
    }
}
