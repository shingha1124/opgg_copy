//
//  OpggTarget.swift
//  opgg
//
//  Created by seongha shin on 2022/08/11.
//

import Alamofire
import Foundation

enum OpggTarget {
    case requestSummonerSearch(name: String)
    case requestSummonerDetail(id: String)
    case requestGameInfos(id: String)
}
extension OpggTarget: BaseTarget {
    var path: String {
        switch self {
        case .requestSummonerSearch:
            return "/api/summoners/kr/autocomplete"
        case .requestSummonerDetail(let id):
            return "/api/summoners/kr/\(id)"
        case .requestGameInfos(let id):
            return "/api/games/kr/summoners/\(id)"
        }
    }
    
    var parameter: [String: Any]? {
        switch self {
        case .requestSummonerSearch(let searchText):
            return ["keyword": searchText]
        case .requestSummonerDetail:
            return ["hl": "ko_KR"]
        case .requestGameInfos:
            return ["hl": "ko_KR", "game_type": "TOTAL"]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .requestSummonerSearch, .requestSummonerDetail, .requestGameInfos:
            return .get
        }
    }
}
