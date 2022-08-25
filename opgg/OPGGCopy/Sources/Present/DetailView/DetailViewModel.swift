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
    
    init(_ summonerId: String) {
        let requestDetail = action.onAppear
            .map { _ in summonerId }
            .flatMap { [unowned self] summonerId in
                self.opggRepository.requestSummonerDetail(summonerId)
            }
            .share()
        
        let successRequestDetail = requestDetail
            .compactMap { $0.value?.data }
            .handleEvents(receiveOutput: { [unowned self] data in
                self.seasonData.updateData(data.seasonsByID)
                self.tierImageData.updateData(data.tiersImageData)
            })
            .share()
        
        successRequestDetail
            .map { $0.name }
            .sink(receiveValue: { [unowned self] name in
                self.state.summonerName = name
            })
            .store(in: &cancellable)
        
        successRequestDetail
            .sink(receiveValue: viewModels.topView.update.summonerDetail.send(_:))
            .store(in: &cancellable)
        
        successRequestDetail
            .map { $0.previousSeasons }
            .sink(receiveValue: viewModels.prevSeasons.update.previousSeasons.send(_:))
            .store(in: &cancellable)
        
        successRequestDetail
            .map { $0.leagueStats }
            .sink(receiveValue: viewModels.leagueStats.update.leagueStats.send(_:))
            .store(in: &cancellable)
        
        requestDetail
            .compactMap { $0.error }
            .sink(receiveValue: {
                print($0)
            })
            .store(in: &cancellable)
    }
}
