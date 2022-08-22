//
//  DetailView.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/22.
//

import SwiftUI

struct DetailView: View {
    
    @ObservedObject private var viewModel: DetailViewModel
    private let infoView: SummonerInfoView
    private let prevSeasonsView: PreviousSeasonsView
    private let leagueStatsView: LeagueStatsView
    
    init(_ viewModel: DetailViewModel) {
        self.viewModel = viewModel
        infoView = SummonerInfoView(viewModel.viewModels.info)
        prevSeasonsView = PreviousSeasonsView(viewModel.viewModels.prevSeasons)
        leagueStatsView = LeagueStatsView(viewModel.viewModels.leagueStats)
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0) {
                infoView
                prevSeasonsView
                leagueStatsView
            }
            .padding(0)
        }
        .padding(0)
        .onAppear {
            viewModel.action.onAppear.send(())
        }
        .background(Color.systemBackground2)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(PreviewMockData.shard.detailViewModel)
            .preferredColorScheme(.dark)
    }
}
