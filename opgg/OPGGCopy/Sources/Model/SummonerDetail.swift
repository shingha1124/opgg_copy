//
//  SummonerDetail.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/22.
//

import Foundation

struct SummonerDetailData: Decodable {
    let data: SummonerDetail
}

struct SummonerDetail: Decodable {
    let id: Int
    let summonerID, acctID, puuid, name: String
    let internalName: String
    let profileImageURL: URL
    let level: Int
    let updatedAt, renewableAt: Date
//    let lpHistories: [LpHistory]
    let previousSeasons: [PreviousSeason]
    let leagueStats: [LeagueStats]
//    let mostChampions: MostChampions
//    let recentChampionStats: [JSONAny]
    let ladderRank: LadderRank?
//    let recentSolorankedAnalysis: [RecentSolorankedAnalysis]
//    let recentNormalAnalysis: [JSONAny]
//    let championsByID: [String: ChampionsByID]
    let seasonsByID: [String: Season]
//    let seasons: [Season]
//    let tiersImageData: [TiersImageDatum]
    
    enum CodingKeys: String, CodingKey {
        case id
        case summonerID = "summoner_id"
        case acctID = "acct_id"
        case puuid, name
        case internalName = "internal_name"
        case profileImageURL = "profile_image_url"
        case level
        case updatedAt = "updated_at"
        case renewableAt = "renewable_at"
//        case teamInfo = "team_info"
//        case lpHistories = "lp_histories"
        case previousSeasons = "previous_seasons"
        case leagueStats = "league_stats"
//        case mostChampions = "most_champions"
//        case recentChampionStats = "recent_champion_stats"
        case ladderRank = "ladder_rank"
//        case recentSolorankedAnalysis = "recent_soloranked_analysis"
//        case recentNormalAnalysis = "recent_normal_analysis"
//        case championsByID = "championsById"
        case seasonsByID = "seasonsById"
//        case seasons, tiersImageData
    }
}

struct LadderRank: Decodable {
    let rank, total: Int
}

struct PreviousSeason: Decodable {
    let seasonID: Int
    let tierInfo: TierInfo
    let createdAt: Date?

    enum CodingKeys: String, CodingKey {
        case seasonID = "season_id"
        case tierInfo = "tier_info"
        case createdAt = "created_at"
    }
}

struct TierInfo: Decodable {
    let tier: Tier?
    let division, lp: Int?
    let tierImageURL: URL
    let borderImageURL: URL?

    enum CodingKeys: String, CodingKey {
        case tier, division, lp
        case tierImageURL = "tier_image_url"
        case borderImageURL = "border_image_url"
    }
}

struct Season: Codable {
    let id, value, displayValue: Int
    let isPreseason: Bool

    enum CodingKeys: String, CodingKey {
        case id, value
        case displayValue = "display_value"
        case isPreseason = "is_preseason"
    }
}

struct LeagueStats: Decodable {
    let queueInfo: QueueInfo
    let tierInfo: TierInfo
    let win: Int
    let lose: Int

    enum CodingKeys: String, CodingKey {
        case queueInfo = "queue_info"
        case tierInfo = "tier_info"
        case win, lose
    }
}

struct QueueInfo: Decodable {
    let id: Int
    let queueTranslate: String
    let gameType: GameType

    enum CodingKeys: String, CodingKey {
        case id
        case queueTranslate = "queue_translate"
        case gameType = "game_type"
    }
}

@frozen
enum GameType: String, Decodable {
    case soloRanked = "SOLORANKED"
    case flexRanked = "FLEXRANKED"
}
