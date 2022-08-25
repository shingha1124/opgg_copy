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
    let rate: Int
    
    init(wins: Int, losses: Int) {
        self.wins = wins
        self.losses = losses
        let totalGame = wins + losses
        if wins == 0 || totalGame == 0 {
            rate = 0
        } else {
            rate = Int((Float(wins) / Float(totalGame)) * 100)
        }
    }
    
    var text: String {
        let winLocalize = LocalizedStringKey.Keys.winCount.value
        let winText = String(format: winLocalize, wins)
        let lossesLocalize = LocalizedStringKey.Keys.lossesCount.value
        let lossesText = String(format: lossesLocalize, losses)
        return "\(winText) \(lossesText)"
    }
}

extension WinRate {
    var rateColor: Color {
        rate >= 60 ? .darkishPink : .steelGrey
    }
}
