//
//  GameListViewModel.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/28.
//

import Combine

final class GameListViewModel: ObservableObject {
    
    struct State {
    }
    
    struct Update {
    }
    
    @Published var state = State()
    let update = Update()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        
    }
}
