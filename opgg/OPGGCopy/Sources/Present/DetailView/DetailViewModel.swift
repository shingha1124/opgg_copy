//
//  DetailViewModel.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/22.
//

import Combine
import Foundation

final class DetailViewModel: ObservableObject {
    struct Action {
        var onAppear = PassthroughSubject<Void, Never>()
    }
    
    struct State {
        var summonerName = ""
    }
    
    struct ViewModels {
        let topView = DetailTopViewModel()
        let prevSeasons = PreviousSeasonsViewModel()
        let leagueStats = LeagueStatsViewModel()
        let summary = SummaryViewModel()
    }
    
    @Published var state = State()
    let action = Action()
    let viewModels = ViewModels()
    
    private var cancellable = Set<AnyCancellable>()
    
    @Inject(\.opggRepository) private var opggRepository: OpggRepository
    @Inject(\.seasonData) private var seasonData: SeasonData
    @Inject(\.tierImageData) private var tierImageData: TierImageData
    
    deinit {
        print("Deinit DetailViewModel")
    }
    
    init(_ summoner: SearchSummoner) {
        let requestDetail = action.onAppear
            .map { _ in summoner.internalName }
            .flatMap { [unowned self] name in
                self.opggRepository.requestSummonerDetail(name)
            }
            .share()
        
        let successRequestDetail = requestDetail
            .compactMap { $0.value?.pageProps.summoner }
            .handleEvents(receiveOutput: { [unowned self] data in
                self.seasonData.updateData(data.seasons)
//                self.tierImageData.updateData(data.tiersImageData)
            })
            .share()
        
        successRequestDetail
            .map { $0.name }
            .sink(receiveValue: { [unowned self] name in
                self.state.summonerName = name
            })
            .store(in: &cancellable)
        
        successRequestDetail
            .sink(receiveValue: viewModels.topView.update.summonerDetail.send)
            .store(in: &cancellable)
        
        successRequestDetail
            .map { $0.previousSeasons }
            .sink(receiveValue: viewModels.prevSeasons.update.previousSeasons.send)
            .store(in: &cancellable)
        
        successRequestDetail
            .map { $0.leagueStats }
            .sink(receiveValue: viewModels.leagueStats.update.leagueStats.send)
            .store(in: &cancellable)
        
        let requestGameInfos = action.onAppear
            .map { _ in summoner.summonerID }
            .flatMap { [unowned self] summonerId in
                self.opggRepository.requestGameInfos(summonerId)
            }
            .share()
        
        let successRequestGameData = requestGameInfos
            .compactMap { $0.value?.data }
            .share()
        
        successRequestGameData
            .sink(receiveValue: viewModels.summary.update.lastGames.send)
            .store(in: &cancellable)
        
        Publishers.MergeMany([
            requestDetail.compactMap { $0.error }.eraseToAnyPublisher(),
            requestGameInfos.compactMap { $0.error }.eraseToAnyPublisher()
        ])
        .sink(receiveValue: {
            print($0)
        })
        .store(in: &cancellable)
    }
}
