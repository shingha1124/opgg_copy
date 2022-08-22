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
    let profileImageURL: URL
    let level: Int
    let updatedAt: Date
    let soloTierInfo: SoloTierInfo?
    
    enum CodingKeys: String, CodingKey {
        case id, puuid, name, level
        case summonerID = "summoner_id"
        case acctID = "acct_id"
        case internalName = "internal_name"
        case profileImageURL = "profile_image_url"
        case updatedAt = "updated_at"
        case soloTierInfo = "solo_tier_info"
    }
    
    init() {
        self.id = 3206495
        self.summonerID = "zkDo7tkDVQsxjkwzskG9-ixLhBHvxOQgB9p9ULVcO1HmtA"
        self.acctID = "_yZjwQxjQTR1Abl7z87BUiXWYk86Sx201WmMaz_tPvzD"
        self.puuid = "-KxBu88Y2Xl0lp2wDMspT1LO-YV5mT8Ipq5rUOTiDWSFt8wMOhL2KwPIxNjcfh7xgcdoS7r9HIx0fw"
        self.name = "신싱하"
        self.internalName = "신싱하"
        self.profileImageURL = URL(string: "https://opgg-static.akamaized.net/images/profile_icons/profileIcon536.jpg?image=q_auto")!
        self.level = 307
        self.updatedAt = Date()
        self.soloTierInfo = SoloTierInfo()
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
    
    init() {
        self.tier = .gold
        self.division = 3
        self.lp = 75
        self.tierImageURL = URL(string: "https://opgg-static.akamaized.net/images/medals_new/gold.png")!
        self.borderImageURL = URL(string: "https://opgg-static.akamaized.net/images/border_new/gold.png")!
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
