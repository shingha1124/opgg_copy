//
//  GameListViewModel.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/28.
//

import Combine

final class GameListViewModel: ObservableObject {
    struct Action {
        let loadMore = PassthroughSubject<Void, Never>()
    }
    
    struct State {
        var viewModels = [GameListItemViewModel]()
        var isLoading = false
    }
    
    struct Update {
        let games = PassthroughSubject<[GameInfo], Never>()
    }
    
    @Published var state = State()
    let action = Action()
    let update = Update()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        update.games
            .map { $0.enumerated().map { GameListItemViewModel(index: $0, game: $1) } }
            .sink(receiveValue: { [unowned self] itemViewModels in
                self.state.viewModels = itemViewModels
            })
            .store(in: &cancellable)
        
        action.loadMore
            .sink(receiveValue: {
                print("loadMore")
            })
            .store(in: &cancellable)
    }
}
