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
    let profileImageURL: URL?
    let level: Int
    let updatedAt, renewableAt: Date?
    let previousSeasons: [PreviousSeason]
    let leagueStats: [LeagueStats]
    let mostChampions: MostChampions?
//    let recentChampionStats: [JSONAny]
    let ladderRank: LadderRank?
//    let recentSolorankedAnalysis: [RecentSolorankedAnalysis]
//    let recentNormalAnalysis: [JSONAny]
    let champions: [Champion]
//    let championsByID: [String: ChampionsByID]
    let runePagesByID: [String: RunePageDatum]
    let runesByID: [String: RuneDatum]
    let spellsByID: [String: Spell]
    let itemsByID: [String: ItemDatum]
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
        case runePagesByID = "runePagesById"
        case runesByID = "runesById"
        case spellsByID = "spellsById"
        case itemsByID = "itemsById"
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

struct Champion: Decodable {
    let id: Int
    let key, name: String
    let imageURL: URL
    let championDescription: String?

    enum CodingKeys: String, CodingKey {
        case id, key, name
        case imageURL = "image_url"
        case championDescription = "description"
    }
}

struct Spell: Decodable {
    let id: Int
    let key, name: String
    let imageURL: URL
    let championDescription: String?

    enum CodingKeys: String, CodingKey {
        case id, key, name
        case imageURL = "image_url"
        case championDescription = "description"
    }
}

struct MostChampions: Decodable {
    let gameType: GameType
    let seasonID, play, win, lose: Int
    let championStats: [[ChampionStats: Int]]

    enum CodingKeys: String, CodingKey {
        case gameType = "game_type"
        case seasonID = "season_id"
        case play, win, lose
        case championStats = "champion_stats"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        gameType = try container.decode(GameType.self, forKey: .gameType)
        seasonID = try container.decode(Int.self, forKey: .seasonID)
        play = try container.decode(Int.self, forKey: .play)
        win = try container.decode(Int.self, forKey: .win)
        lose = try container.decode(Int.self, forKey: .lose)
        let stats = try container.decode([[String: Int]].self, forKey: .championStats)
        championStats = stats.reduce(into: [[ChampionStats: Int]]()) { array, stats in
            let keyValues = stats.reduce(into: [ChampionStats: Int]()) {
                guard let key = ChampionStats(rawValue: $1.key) else {
                    return
                }
                $0[key] = $1.value
            }
            array.append(keyValues)
        }
    }
}

// MARK: - RunePagesByID
struct RunePageDatum: Codable {
    let id: Int
    let name, runePagesByIDDescription, slogan: String
    let imageURL: URL

    enum CodingKeys: String, CodingKey {
        case id, name
        case runePagesByIDDescription = "description"
        case slogan
        case imageURL = "image_url"
    }
}

// MARK: - RunesByID
struct RuneDatum: Decodable {
    let id, pageID, slotSequence, runeSequence: Int
    let key, name, shortDesc, longDesc: String
    let imageURL: URL

    enum CodingKeys: String, CodingKey {
        case id
        case pageID = "page_id"
        case slotSequence = "slot_sequence"
        case runeSequence = "rune_sequence"
        case key, name
        case shortDesc = "short_desc"
        case longDesc = "long_desc"
        case imageURL = "image_url"
    }
}

// MARK: - ItemsByID
struct ItemDatum: Decodable {
    let id: Int
    let name: String
    let imageURL: URL
    let isMythic: Bool
    let intoItems, fromItems: [Int]?
    let gold: Gold
    let plaintext, itemsByIDDescription: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "image_url"
        case isMythic = "is_mythic"
        case intoItems = "into_items"
        case fromItems = "from_items"
        case gold, plaintext
        case itemsByIDDescription = "description"
    }
}

// MARK: - Gold
struct Gold: Decodable {
    let sell, total, base: Int
    let purchasable: Bool
}

@frozen
enum ChampionStats: String, Decodable {
    case id, play, win, lose
    case kill, death, assist
    case goldEarned = "gold_earned"
    case minionKill = "minion_kill"
    case turretKill = "turret_kill"
    case neutralMinionKill = "neutral_minion_kill"
    case damageDealt = "damage_dealt"
    case damageTaken = "damage_taken"
    case physicalDamageDealt = "physical_damage_dealt"
    case magicDamageDealt = "magic_damage_dealt"
    case mostKill = "most_kill"
    case maxKill = "max_kill"
    case maxDeath = "max_death"
    case doubleKill = "double_kill"
    case tripleKill = "triple_kill"
    case quadraKill = "quadra_kill"
    case pentaKill = "penta_kill"
    case gameLengthSecond = "game_length_second"
}

struct Season: Decodable {
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
    case ranked = "RANKED"
    case normal = "NORMAL"
    case soloRanked = "SOLORANKED"
    case flexRanked = "FLEXRANKED"
    case aram = "ARAM"
    
    var localizeKey: LocalizedKey {
        switch self {
        case .ranked:
            return .rankNotFound
        case .normal:
            return .rankNotFound
        case .soloRanked:
            return .soloRanked
        case .flexRanked:
            return .flexRanked
        case .aram:
            return .aram
        }
    }
}
