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
}

extension WinRate {
    var rateColor: Color {
        rate >= 60 ? .darkishPink : .steelGrey
    }
}
