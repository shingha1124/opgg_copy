//
//  LocalizedStringKey+Extension.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/25.
//

import SwiftUI

enum LocalizedKey: String {
    case ladderRank
    case ladderRankEmpty
    case update
    case inGame
    case leagueStatsWinLose
    
    case summaryTitle
    case winRate
    case kdaFloat
    
    case champScoreTitle
    case gameCount
    
    case playedWithTitle
    
    case bestPlayTitle
}

extension LocalizedKey {
//    func with(args: [CVarArg]) -> String {
//        String(format: self.value, args)
//    }
    
    var value: String {
        NSLocalizedString(self.rawValue, comment: "")
    }
}
