//
//  SummaryLastGameViewModel.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/25.
//

import Combine

final class SummaryLastGameViewModel: ObservableObject {
    
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
