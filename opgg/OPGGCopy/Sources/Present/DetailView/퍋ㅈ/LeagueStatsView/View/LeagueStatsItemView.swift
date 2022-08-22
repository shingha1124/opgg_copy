//
//  LeagueStatsItemView.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/22.
//

import SwiftUI

struct LeagueStatsItemView: View {
    
    @ObservedObject var viewModel: LeagueStatsItemViewModel
    
    init(_ viewModel: LeagueStatsItemViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        return AsyncImage(url: viewModel.state.tierImageUrl) { $0.resizable() } placeholder: { Color.darkishPink }
        .frame(width: 64, height: 64, alignment: .topLeading)
        .clipShape(RoundedRectangle(cornerRadius: 32))
        .foregroundColor(.black)
    }
}

struct LeagueStatsItemView_Previews: PreviewProvider {
    static var previews: some View {
        LeagueStatsItemView(LeagueStatsItemViewModel(PreviewMockData.shard.leagueStats))
    }
}
