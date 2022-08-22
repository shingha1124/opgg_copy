//
//  MainViewModel.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/21.
//

import Combine

final class MainViewModel: ObservableObject {
    struct State {
        var searchSummoner: [SearchSummonerCellViewModel] = []
        var searchListVisibilty: ViewVisibility = .gone
    }
    
    struct ViewModels {
        let searchSummoner: SummonerSearchViewModel
    }
    
    let viewModels: ViewModels
    @Published var state = State()
    @Inject(\.opggRepository) private var opggRepository: OpggRepository
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        let searchViewModel = SummonerSearchViewModel()
        viewModels = ViewModels(searchSummoner: searchViewModel)
        
        let requestSearchSummoner = searchViewModel.state.searchText
            .filter { !$0.isEmpty }
            .flatMap { [unowned self] name in
                self.opggRepository.requestSearchSummoner(name)
            }
            .share()
        
        let successSummoners = requestSearchSummoner
            .compactMap { $0.value?.data }
            .share()
        
        let searchListViewModels = successSummoners
            .map { $0.map { SearchSummonerCellViewModel($0) } }
            .share()
        
        searchListViewModels
            .sink { [unowned self] summoners in
                self.state.searchSummoner = summoners
            }
            .store(in: &cancellable)
        
        Publishers.Merge(
            searchViewModel.state.searchText.map { !$0.isEmpty },
            successSummoners.map { !$0.isEmpty }
        )
        .map { $0 ? .visible : .gone }
        .sink(receiveValue: { [unowned self] visibilty in
            self.state.searchListVisibilty = visibilty
        })
        .store(in: &cancellable) 
    }
}
