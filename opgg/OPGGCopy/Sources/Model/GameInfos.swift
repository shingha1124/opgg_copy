//
//  InGameData.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/25.
//

import Foundation

struct GameInfos: Decodable {
    let data: SummonerDetail
}

struct GameInfo: Decodable {
    let id: String
    let createdAt: Date
    let gameMap: GameMap
    let queueInfo: QueueInfo
    let version: Version
    let gameLengthSecond: Int
    let isRemake, isOpscoreActive, isRecorded: Bool
    let averageTierInfo: TierInfo
    let participants: [Participant]
    let teams: [Team]
    let myData: Participant

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case gameMap = "game_map"
        case queueInfo = "queue_info"
        case version
        case gameLengthSecond = "game_length_second"
        case isRemake = "is_remake"
        case isOpscoreActive = "is_opscore_active"
        case isRecorded = "is_recorded"
        case averageTierInfo = "average_tier_info"
        case participants, teams, myData
    }
}

enum GameMap: String, Decodable {
    case howlingAbyss = "HOWLING_ABYSS"
    case summonersRigt = "SUMMONERS_RIFT"
}

// MARK: - MyData
struct Participant: Decodable {
    let summoner: Summoner
    let participantID, championID: Int
    let teamKey: TeamKey
    let position: Position?
    let items: [Int]
    let trinketItem: Int
    let rune: Rune
    let spells: [Int]
    let stats: Stats
    let tierInfo: TierInfo

    enum CodingKeys: String, CodingKey {
        case summoner
        case participantID = "participant_id"
        case championID = "champion_id"
        case teamKey = "team_key"
        case position, items
        case trinketItem = "trinket_item"
        case rune, spells, stats
        case tierInfo = "tier_info"
    }
}

enum Position: String, Decodable {
    case adc = "ADC"
    case jungle = "JUNGLE"
    case mid = "MID"
    case support = "SUPPORT"
    case top = "TOP"
}

// MARK: - Rune
struct Rune: Decodable {
    let primaryPageID, primaryRuneID, secondaryPageID: Int

    enum CodingKeys: String, CodingKey {
        case primaryPageID = "primary_page_id"
        case primaryRuneID = "primary_rune_id"
        case secondaryPageID = "secondary_page_id"
    }
}

// MARK: - Stats
struct Stats: Decodable {
    let championLevel, damageSelfMitigated, damageDealtToObjectives, damageDealtToTurrets: Int
    let magicDamageDealtPlayer, physicalDamageTaken, physicalDamageDealtToChampions, totalDamageTaken: Int
    let totalDamageDealt, totalDamageDealtToChampions, largestCriticalStrike, timeCcingOthers: Int
    let visionScore, visionWardsBoughtInGame, sightWardsBoughtInGame, wardKill: Int
    let wardPlace, turretKill, barrackKill, kill: Int
    let death, assist, largestMultiKill, largestKillingSpree: Int
    let minionKill, neutralMinionKillTeamJungle, neutralMinionKillEnemyJungle, neutralMinionKill: Int
    let goldEarned, totalHeal: Int
    let result: GameResult
    let opScore, opScoreRank: Int
    let isOpscoreMaxInTeam: Bool

    enum CodingKeys: String, CodingKey {
        case championLevel = "champion_level"
        case damageSelfMitigated = "damage_self_mitigated"
        case damageDealtToObjectives = "damage_dealt_to_objectives"
        case damageDealtToTurrets = "damage_dealt_to_turrets"
        case magicDamageDealtPlayer = "magic_damage_dealt_player"
        case physicalDamageTaken = "physical_damage_taken"
        case physicalDamageDealtToChampions = "physical_damage_dealt_to_champions"
        case totalDamageTaken = "total_damage_taken"
        case totalDamageDealt = "total_damage_dealt"
        case totalDamageDealtToChampions = "total_damage_dealt_to_champions"
        case largestCriticalStrike = "largest_critical_strike"
        case timeCcingOthers = "time_ccing_others"
        case visionScore = "vision_score"
        case visionWardsBoughtInGame = "vision_wards_bought_in_game"
        case sightWardsBoughtInGame = "sight_wards_bought_in_game"
        case wardKill = "ward_kill"
        case wardPlace = "ward_place"
        case turretKill = "turret_kill"
        case barrackKill = "barrack_kill"
        case kill, death, assist
        case largestMultiKill = "largest_multi_kill"
        case largestKillingSpree = "largest_killing_spree"
        case minionKill = "minion_kill"
        case neutralMinionKillTeamJungle = "neutral_minion_kill_team_jungle"
        case neutralMinionKillEnemyJungle = "neutral_minion_kill_enemy_jungle"
        case neutralMinionKill = "neutral_minion_kill"
        case goldEarned = "gold_earned"
        case totalHeal = "total_heal"
        case result
        case opScore = "op_score"
        case opScoreRank = "op_score_rank"
        case isOpscoreMaxInTeam = "is_opscore_max_in_team"
    }
}

enum GameResult: String, Codable {
    case lose = "LOSE"
    case win = "WIN"
}

// MARK: - Summoner
struct Summoner: Codable {
    let id: Int
    let summonerID, acctID, puuid, name: String
    let internalName: String
    let profileImageURL: String
    let level: Int
    let updatedAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case summonerID = "summoner_id"
        case acctID = "acct_id"
        case puuid, name
        case internalName = "internal_name"
        case profileImageURL = "profile_image_url"
        case level
        case updatedAt = "updated_at"
    }
}

enum TeamKey: String, Decodable {
    case blue = "BLUE"
    case red = "RED"
}

// MARK: - Team
struct Team: Decodable {
    let key: TeamKey
    let gameStat: GameStat

    enum CodingKeys: String, CodingKey {
        case key
        case gameStat = "game_stat"
    }
}

// MARK: - GameStat
struct GameStat: Decodable {
    let dragonKill, baronKill, towerKill: Int
    let isWin, isRemake: Bool
    let kill, death, assist, goldEarned: Int

    enum CodingKeys: String, CodingKey {
        case dragonKill = "dragon_kill"
        case baronKill = "baron_kill"
        case towerKill = "tower_kill"
        case isWin = "is_win"
        case isRemake = "is_remake"
        case kill, death, assist
        case goldEarned = "gold_earned"
    }
}

enum Version: String, Decodable {
    case the12154581416 = "12.15.458.1416"
    case the12164617002 = "12.16.461.7002"
}

// MARK: - Meta
struct Meta: Decodable {
    let firstGameCreatedAt, lastGameCreatedAt: Date

    enum CodingKeys: String, CodingKey {
        case firstGameCreatedAt = "first_game_created_at"
        case lastGameCreatedAt = "last_game_created_at"
    }
}
