//
//  OpggRepositoryImpl.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/21.
//

import Combine
import Foundation

final class OpggRepositoryImpl: NetworkRepository<OpggTarget>, OpggRepository {
    func requestSearchSummoner(_ searchText: String) -> AnyPublisher<Result<SearchSummoners, APIError>, Never> {
        provider
            .request(.requestSummonerSearch(name: searchText))
            .map(SearchSummoners.self)
    }
    
    func requestSummonerDetail(_ name: String) -> AnyPublisher<Result<SummonerDetailData2, APIError>, Never> {
        provider
            .request(.requestSummonerDetail(name: name))
            .map(SummonerDetailData2.self)
    }
    
    func requestGameInfos(_ summonerId: String) -> AnyPublisher<Result<GameInfos, APIError>, Never> {
        provider
            .request(.requestGameInfos(id: summonerId))
            .map(GameInfos.self)
    }
}
