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
    
    init() {
        self.kill = 0
        self.death = 0
        self.assist = 0
        self.kda = 0
        
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
        
        self.kill = summary.kill
        self.death = summary.death
        self.assist = summary.assist
        
        let totalGame = summary.win + summary.lose
        self.killRate = Float(summary.kill) / Float(totalGame)
        self.deathRate = Float(summary.death) / Float(totalGame)
        self.assistRate = Float(summary.assist) / Float(totalGame)
        
        self.kda = Float(summary.kill + summary.assist) / Float(summary.death)
    }
}

extension GameSummary {
    var kdaColor: Color {
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
