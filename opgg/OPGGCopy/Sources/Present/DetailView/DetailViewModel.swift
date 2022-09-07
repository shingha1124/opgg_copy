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
        let gameList = GameListViewModel()
    }
    
    @Published var state = State()
    let action = Action()
    let viewModels = ViewModels()
    
    private var cancellable = Set<AnyCancellable>()
    
    @Inject(\.opggRepository) private var opggRepository: OpggRepository
    @Inject(\.seasonData) private var seasonData: SeasonData
    @Inject(\.championData) private var championData: ChampionData
    @Inject(\.spellData) private var spellData: SpellData
    @Inject(\.runePageData) private var runePageData: RunePageData
    @Inject(\.runeData) private var runeData: RuneData
    @Inject(\.itemData) private var itemData: ItemData
    
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
            .compactMap { $0.value?.pageProps }
            .handleEvents(receiveOutput: { [unowned self] data in
                self.seasonData.updateData(data.summoner.seasons)
                self.championData.updateData(data.summoner.champions)
                self.spellData.updateData(data.summoner.spellsByID)
                self.runePageData.updateData(data.summoner.runePagesByID)
                self.runeData.updateData(data.summoner.runesByID)
                self.itemData.updateData(data.summoner.itemsByID)
            })
            .share()
        
        successRequestDetail
            .map { $0.summoner.name }
            .sink(receiveValue: { [unowned self] name in
                self.state.summonerName = name
            })
            .store(in: &cancellable)
        
        successRequestDetail
            .map { $0.summoner }
            .sink(receiveValue: viewModels.topView.update.summonerDetail.send)
            .store(in: &cancellable)
        
        successRequestDetail
            .map { $0.summoner.previousSeasons }
            .sink(receiveValue: viewModels.prevSeasons.update.previousSeasons.send)
            .store(in: &cancellable)
        
        successRequestDetail
            .map { $0.summoner.leagueStats }
            .sink(receiveValue: viewModels.leagueStats.update.leagueStats.send)
            .store(in: &cancellable)
        
        successRequestDetail
            .sink(receiveValue: viewModels.summary.update.summonerDetail.send)
            .store(in: &cancellable)
        
        successRequestDetail
            .map { $0.games.data }
            .sink(receiveValue: viewModels.gameList.update.games.send)
            .store(in: &cancellable)
        
        Publishers.MergeMany([
            requestDetail.compactMap { $0.error }.eraseToAnyPublisher()
        ])
        .sink(receiveValue: {
            print($0)
        })
        .store(in: &cancellable)
    }
}
