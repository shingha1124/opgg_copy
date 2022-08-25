//
//  OpggRepository.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/21.
//

import Combine
import Foundation

protocol OpggRepository {
    func requestSearchSummoner(_ searchText: String) -> AnyPublisher<Result<SearchSummoners, APIError>, Never>
    func requestSummonerDetail(_ summonerId: String) -> AnyPublisher<Result<SummonerDetailData, APIError>, Never>
    func requestGameInfos(_ summonerId: String) -> AnyPublisher<Result<GameInfos, APIError>, Never>
}
