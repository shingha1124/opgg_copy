//
//  SummonerDetail.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/22.
//

import Foundation

struct SummonerDetailData2: Decodable {
    let pageProps: PageProps
}

struct PageProps: Decodable {
    let summoner: SummonerDetail
    let games: GameInfos
    
    enum CodingKeys: String, CodingKey {
        case summoner = "data"
        case games
    }
}

struct SummonerDetail: Decodable {
    let id: Int
    let summonerID, acctID, puuid, name: String
    let internalName: String
    let profileImageURL: URL
    let level: Int
    let updatedAt, renewableAt: Date
    let previousSeasons: [PreviousSeason]
    let leagueStats: [LeagueStats]
    let mostChampions: MostChampions
//    let recentChampionStats: [JSONAny]
    let ladderRank: LadderRank?
//    let recentSolorankedAnalysis: [RecentSolorankedAnalysis]
//    let recentNormalAnalysis: [JSONAny]
    let champions: [Champion]
//    let championsByID: [String: ChampionsByID]
//    let runePagesByID: [String: RunePagesByID]
//    let runesByID: [String: RunesByID]
//    let spellsByID: [String: Champion]
//    let itemsByID: [String: ItemsByID]
    let seasons: [Season]
//    let seasonsByID: [String: Season]

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
        case previousSeasons = "previous_seasons"
        case leagueStats = "league_stats"
        case mostChampions = "most_champions"
//        case recentChampionStats = "recent_champion_stats"
        case ladderRank = "ladder_rank"
//        case recentSolorankedAnalysis = "recent_soloranked_analysis"
//        case recentNormalAnalysis = "recent_normal_analysis"
        case champions
//        case championsByID = "championsById"
//        case runePagesByID = "runePagesById"
//        case runesByID = "runesById"
//        case spellsByID = "spellsById"
//        case itemsByID = "itemsById"
        case seasons
//        case seasonsByID = "seasonsById"
    }
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

struct LadderRank: Decodable {
    let rank, total: Int
}

struct Champion: Codable {
    let id: Int
    let key, name: String
    let imageURL: String
    let championDescription: String?

    enum CodingKeys: String, CodingKey {
        case id, key, name
        case imageURL = "image_url"
        case championDescription = "description"
    }
}

struct MostChampions: Codable {
    let gameType: String
    let seasonID, play, win, lose: Int
    let championStats: [[String: Int]]

    enum CodingKeys: String, CodingKey {
        case gameType = "game_type"
        case seasonID = "season_id"
        case play, win, lose
        case championStats = "champion_stats"
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

@frozen
enum GameType: String, Decodable {
    case soloRanked = "SOLORANKED"
    case flexRanked = "FLEXRANKED"
    case aram = "ARAM"
}
