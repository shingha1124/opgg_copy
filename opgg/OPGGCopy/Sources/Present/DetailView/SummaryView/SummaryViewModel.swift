//
//  SummaryViewModel.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/25.
//

import Combine

final class SummaryViewModel: ObservableObject {
    
    struct State {
    }
    
    struct Update {
    }
    
    struct ViewModels {
        let lastGame = SummaryLastGameViewModel()
    }
    
    @Published var state = State()
    let update = Update()
    let viewModels = ViewModels()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
    }
}
