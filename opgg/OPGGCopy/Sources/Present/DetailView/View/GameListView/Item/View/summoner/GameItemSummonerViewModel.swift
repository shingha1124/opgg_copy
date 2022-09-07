//
//  GameItemSummonerView.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/28.
//

import Combine
import Foundation

final class GameItemSummonerViewModel: ObservableObject {
    
    struct State {
        var imageUrl: URL?
        var spell1: URL?
        var spell2: URL?
        var rune1: URL?
        var rune2: URL?
        
        var summary = GameSummary()
        var killRate = 0
    }
    
    struct Update {
    }
    
    @Published var state = State()
    let update = Update()
    private var cancellable = Set<AnyCancellable>()
    
    @Inject(\.championData) private var championData: ChampionData
    @Inject(\.spellData) private var spellData: SpellData
    @Inject(\.runePageData) private var runePageData: RunePageData
    @Inject(\.runeData) private var runeData: RuneData
    
    init(_ game: GameInfo) {
        state.imageUrl = championData[game.myData.championID]?.imageURL
        
        state.spell1 = spellData[game.myData.spells[0]]?.imageURL
        state.spell2 = spellData[game.myData.spells[1]]?.imageURL
        
        state.rune1 = runeData[game.myData.rune.primaryRuneID]?.imageURL
        state.rune2 = runePageData[game.myData.rune.primaryPageID]?.imageURL
        
        state.summary = GameSummary(game)
        
        let myData = game.myData
        guard let team = game.teams.first(where: { $0.key == game.myData.teamKey }) else {
            return
        }
        
        let totalKill = Float(team.gameStat.kill)
        let myKill = Float(myData.stats.kill + myData.stats.assist)
        let killRate = ((myKill / totalKill) * 100.0).rounded()
        
        state.killRate = Int(killRate)
    }
}
 
