//
//  MainViewModel.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/21.
//

import Combine

final class MainViewModel: ObservableObject {
    struct State {
        var searchListVisibilty: ViewVisibility = .gone
    }
    
    struct ViewModels {
        let searchSummoner = SummonerSearchViewModel()
        let searchList = SearchSummonerListViewModel()
    }
    
    let viewModels = ViewModels()
    @Published var state = State()
    @Inject(\.opggRepository) private var opggRepository: OpggRepository
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        let requestSearchSummoner = viewModels.searchSummoner.state.searchText
            .filter { !$0.isEmpty }
            .flatMap { [unowned self] name in
                self.opggRepository.requestSearchSummoner(name)
            }
            .share()
        
        let successSummoners = requestSearchSummoner
            .compactMap { $0.value?.data }
            .share()
        
        successSummoners
            .sink(receiveValue: viewModels.searchList.update.summoners.send(_:))
            .store(in: &cancellable)
        
        requestSearchSummoner
            .compactMap { $0.error }
            .sink(receiveValue: {
                print($0)
            })
            .store(in: &cancellable)
        
        Publishers.Merge(
            viewModels.searchSummoner.state.searchText.map { !$0.isEmpty },
            successSummoners.map { !$0.isEmpty }
        )
        .map { $0 ? .visible : .gone }
        .sink(receiveValue: { [unowned self] visibilty in
            self.state.searchListVisibilty = visibilty
        })
        .store(in: &cancellable) 
    }
}
