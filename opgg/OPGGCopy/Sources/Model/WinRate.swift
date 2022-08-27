//
//  WinRate.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/23.
//

import SwiftUI

struct WinRate {
    let wins: Int
    let losses: Int
    let rate: Float
    var total: Int {
        wins + losses
    }
    
    init(wins: Int, losses: Int) {
        self.wins = wins
        self.losses = losses
        let totalGame = wins + losses
        if wins == 0 || totalGame == 0 {
            rate = 0
        } else {
            rate = (Float(wins) / Float(totalGame)) * 100
        }
    }
    
    init(_ games: [GameInfo]) {
        let summary = games.reduce(into: (win: 0, lose: 0)) {
            $0.win += $1.myData.stats.result == .win ? 1 : 0
            $0.lose += $1.myData.stats.result == .lose ? 1 : 0
        }
        self.init(wins: summary.win, losses: summary.lose)
    }
}

extension WinRate {
    var rateColor: Color {
        rate >= 60 ? .darkishPink : .darkgrey
    }
}
