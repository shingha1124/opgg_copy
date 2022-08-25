//
//  SearchSummonerListViewModel.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/24.
//

import Combine
import Foundation

final class SearchSummonerListViewModel: ObservableObject, Identifiable {
    struct State {
        var items = [SearchSummonerCellViewModel]()
        var isActive = false
    }
    
    struct Update {
        let summoners = PassthroughSubject<[SearchSummoner], Never>()
    }
    
    @Published var state = State()
    let update = Update()
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        let itemViewModels = update.summoners
            .map { $0.map { SearchSummonerCellViewModel($0) } }
            .share()
        
        itemViewModels
            .sink(receiveValue: { [unowned self] items in
                self.state.items = items
            })
            .store(in: &cancellable)
    }
}
