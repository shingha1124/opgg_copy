//
//  LeagueStatsView.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/22.
//

import SwiftUI

struct LeagueStatsView: View {
    
    @ObservedObject var viewModel: LeagueStatsViewModel
    
    init(_ viewModel: LeagueStatsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(viewModel.state.items) { item in
                    LeagueStatsItemView(item)
                }
            }
            .padding([.horizontal], 16)
        }
        .padding([.vertical], 16)
    }
}

struct LeagueStatsView_Previews: PreviewProvider {
    static var previews: some View {
        LeagueStatsView(LeagueStatsViewModel())
    }
}
