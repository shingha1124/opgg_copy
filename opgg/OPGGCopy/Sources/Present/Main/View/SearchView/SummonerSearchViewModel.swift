//
//  SummonerSearchViewModel.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/22.
//

import Combine

final class SummonerSearchViewModel: ObservableObject {
    struct Action {
        var changedSearchText = PassthroughSubject<String, Never>()
    }
    
    struct State {
        var searchText = PassthroughSubject<String, Never>()
    }
    
    let action = Action()
    @Published var state = State()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        action.changedSearchText
            .sink(receiveValue: state.searchText.send)
            .store(in: &cancellable)
    }
}
