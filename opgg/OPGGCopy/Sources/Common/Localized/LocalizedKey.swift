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
    
    case champScoreTitle
    case gameCount
    
    case playedWithTitle
    
    case bestPlayTitle
    
    case win
    case lose
    
    // MARK: Rank
    case soloRanked
    case flexRanked
    case aram
    case rankNotFound
    
    case killRate
    
    case dayAgo
    case hourAgo
    case minuteAgo
}

extension LocalizedKey {
    var value: String {
        NSLocalizedString(self.rawValue, comment: "")
    }
}
