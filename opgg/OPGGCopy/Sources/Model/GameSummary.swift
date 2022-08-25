//
//  GameSummary.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/25.
//

import SwiftUI

struct GameSummary {
    let kill: Int
    let death: Int
    let assist: Int
    let killRate: Float
    let deathRate: Float
    let assistRate: Float
    let kda: Float
    
    let win: Int
    let lose: Int
    let totalGameCount: Int
    let winRate: Int
    
    init() {
        self.kill = 0
        self.death = 0
        self.assist = 0
        self.kda = 0
        
        self.win = 0
        self.lose = 0
        self.totalGameCount = 0
        self.winRate = 0
        
        self.killRate = 0
        self.deathRate = 0
        self.assistRate = 0
    }
    
    init(_ games: [GameInfo]) {
        let summary = games.reduce(into: (kill: 0, death: 0, assist: 0, win: 0, lose: 0)) {
            $0.kill += $1.myData.stats.kill
            $0.death += $1.myData.stats.death
            $0.assist += $1.myData.stats.assist
            $0.win += $1.myData.stats.result == .win ? 1 : 0
            $0.lose += $1.myData.stats.result == .lose ? 1 : 0
        }
        
        let totalGame = summary.win + summary.lose
        var winRate = 0
        if summary.win == 0 || totalGame == 0 {
            winRate = 0
        } else {
            winRate = Int((Float(summary.win) / Float(totalGame)) * 100)
        }
        
        self.win = summary.win
        self.lose = summary.lose
        self.winRate = winRate
        self.totalGameCount = totalGame
        
        self.kill = summary.kill
        self.death = summary.death
        self.assist = summary.assist
        
        self.killRate = Float(summary.kill) / Float(totalGame)
        self.deathRate = Float(summary.death) / Float(totalGame)
        self.assistRate = Float(summary.assist) / Float(totalGame)
        
        self.kda = Float(summary.kill + summary.assist) / Float(summary.death)
    }
}

extension GameSummary {
    var winRateColor: Color {
        winRate >= 60 ? .darkishPink : .steelGrey
    }
    
    var kdaRateColor: Color {
        switch kda {
        case let value where value < 3:
            return .steelGrey
        case let value where value < 4:
            return .greenBlue
        case let value where value < 5:
            return .blue0
        default:
            return .darkishPink
        }
    }
}

extension GameSummary {
    func kdaParsedTexts(_ size: CGFloat) -> [ParsedText] {
        let kill = ParsedText(
            text: String(format: "%.1f", killRate),
            color: Color.grey26.uiColor,
            font: .systemFont(ofSize: size, weight: .bold))
        
        let seperater1 = ParsedText(text: " / ", color: Color.grey26.uiColor, font: .systemFont(ofSize: size))
        
        let death = ParsedText(
            text: String(format: "%.1f", deathRate),
            color: Color.red229.uiColor,
            font: .systemFont(ofSize: size, weight: .bold))
        
        let seperater2 = ParsedText(text: " / ", color: Color.grey26.uiColor, font: .systemFont(ofSize: size))
        
        let assist = ParsedText(
            text: String(format: "%.1f", assistRate),
            color: Color.grey26.uiColor,
            font: .systemFont(ofSize: size, weight: .bold))
        
        return [kill, seperater1, death, seperater2, assist]
    }
}
