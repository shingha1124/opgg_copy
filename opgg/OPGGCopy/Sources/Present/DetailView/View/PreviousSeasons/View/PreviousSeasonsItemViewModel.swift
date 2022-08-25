//
//  PreviousSeasonsItemViewModel.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/22.
//

import Combine
import Foundation

final class PreviousSeasonsItemViewModel: ObservableObject, Identifiable {
    struct State {
        var season = ""
        var tier = ""
        var division: Int?
    }
    
    @Published var state = State()
    private var cancellable = Set<AnyCancellable>()
    @Inject(\.seasonData) private var seasonData: SeasonData
    
    init(_ prevSeason: PreviousSeason) {
        guard let seasonData = seasonData[prevSeason.seasonID],
              let tier = prevSeason.tierInfo.tier else {
            return
        }
        
        state.season = "S\(seasonData.displayValue)"
        state.tier = tier.upperName
        state.division = prevSeason.tierInfo.division
    }
}
