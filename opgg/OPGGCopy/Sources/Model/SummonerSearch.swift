//
//  Summoner.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/21.
//

import Foundation

//swiftlint: disable force_unwrapping

struct SearchSummoners: Decodable {
    let data: [SearchSummoner]
}

struct SearchSummoner: Decodable {
    let id: Int
    let summonerID, acctID, puuid, name: String
    let internalName: String
    let profileImageURL: URL?
    let level: Int
    let soloTierInfo: SoloTierInfo?
    
    enum CodingKeys: String, CodingKey {
        case id, puuid, name, level
        case summonerID = "summoner_id"
        case acctID = "acct_id"
        case internalName = "internal_name"
        case profileImageURL = "profile_image_url"
        case soloTierInfo = "solo_tier_info"
    }
}

struct SoloTierInfo: Decodable {
    let tier: Tier
    let division, lp: Int
    let tierImageURL, borderImageURL: URL

    enum CodingKeys: String, CodingKey {
        case tier, division, lp
        case tierImageURL = "tier_image_url"
        case borderImageURL = "border_image_url"
    }
}

@frozen
enum Tier: String, Decodable {
    case iron = "IRON"
    case bronze = "BRONZE"
    case silver = "SILVER"
    case gold = "GOLD"
    case platinum = "PLATINUM"
    case diamond = "DIAMOND"
    case master = "MASTER"
    case grandMaster = "GRANDMASTER"
    case challenger = "CHALLENGER"
    
    var name: String {
        var tierText = self.rawValue.lowercased()
        let first = String(tierText.removeFirst()).uppercased()
        return first + tierText
    }
    
    var upperName: String {
        self.rawValue
    }
}
