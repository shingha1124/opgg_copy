//
//  PreviewMockData.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/22.
//

import Foundation

final class PreviewMockData {
    
    //swiftlint: disable force_unwrapping
    
    static let shard = PreviewMockData()
    
    private init() {}
    
    var searchSummoner: SearchSummoner {
        SearchSummoner(
            id: 3206495,
            summonerID: "zkDo7tkDVQsxjkwzskG9-ixLhBHvxOQgB9p9ULVcO1HmtA",
            acctID: "_yZjwQxjQTR1Abl7z87BUiXWYk86Sx201WmMaz_tPvzD",
            puuid: "-KxBu88Y2Xl0lp2wDMspT1LO-YV5mT8Ipq5rUOTiDWSFt8wMOhL2KwPIxNjcfh7xgcdoS7r9HIx0fw",
            name: "신싱하",
            internalName: "신싱하",
            profileImageURL: URL(string: "https://opgg-static.akamaized.net/images/profile_icons/profileIcon536.jpg?image=q_auto")!,
            level: 307,
            soloTierInfo: soloTierInfo
        )
    }
    
    var soloTierInfo: SoloTierInfo {
        SoloTierInfo(
            tier: .gold,
            division: 3,
            lp: 75,
            tierImageURL: URL(string: "https://opgg-static.akamaized.net/images/medals_new/gold.png")!,
            borderImageURL: URL(string: "https://opgg-static.akamaized.net/images/border_new/gold.png")!
        )
    }
    
    var detailViewModel: DetailViewModel {
        DetailViewModel("zkDo7tkDVQsxjkwzskG9-ixLhBHvxOQgB9p9ULVcO1HmtA")
    }
    
    var previousSeason: PreviousSeason {
        PreviousSeason(
            seasonID: 17,
            tierInfo: tierInfo,
            createdAt: Date())
    }
    
    var tierInfo: TierInfo {
        TierInfo(
            tier: .bronze,
            division: 1,
            lp: 50,
            tierImageURL: URL(string: "https://opgg-static.akamaized.net/images/medals_new/bronze.png")!,
            borderImageURL: URL(string: "https://opgg-static.akamaized.net/images/border_new/bronze.png")!
        )
    }
    
    var queueInfo: QueueInfo {
        QueueInfo(
            id: 4,
            queueTranslate: "개인/2인 랭크 게임",
            gameType: .soloRanked)
    }
    
    var leagueStats: LeagueStats {
        LeagueStats(
            queueInfo: queueInfo,
            tierInfo: tierInfo,
            win: 56,
            lose: 57)
    }
}
