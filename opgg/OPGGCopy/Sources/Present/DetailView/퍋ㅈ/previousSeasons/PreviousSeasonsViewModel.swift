//
//  previousSeasonsViewModel.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/22.
//

import Combine
import Foundation

final class PreviousSeasonsViewModel: ObservableObject {
    
    struct State {
        var items = [PreviousSeasonsItemViewModel]()
    }
    
    struct Update {
        let previousSeasons = PassthroughSubject<[PreviousSeason], Never>()
    }
    
    @Published var state = State()
    let update = Update()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        update.previousSeasons
            .map { $0.map { PreviousSeasonsItemViewModel($0) } }
            .sink(receiveValue: { [unowned self] items in
                self.state.items = items
            })
            .store(in: &cancellable)
    }
}
