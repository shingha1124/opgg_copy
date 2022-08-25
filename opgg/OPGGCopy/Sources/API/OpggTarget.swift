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
    case requestSummonerDetail(name: String)
    case requestGameInfos(id: String)
}
extension OpggTarget: BaseTarget {
    var path: String {
        switch self {
        case .requestSummonerSearch:
            return "/api/summoners/kr/autocomplete"
        case .requestSummonerDetail(let name):
            return "_next/data/qx1tV_J8eyd7sy37QyPtj/summoners/kr/\(name).json"
        case .requestGameInfos(let id):
            return "/api/games/kr/summoners/\(id)"
        }
    }
    
    var parameter: [String: Any]? {
        switch self {
        case .requestSummonerSearch(let searchText):
            return ["keyword": searchText]
        case .requestSummonerDetail(let name):
            return ["region": "kr", "summoner": name]
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
