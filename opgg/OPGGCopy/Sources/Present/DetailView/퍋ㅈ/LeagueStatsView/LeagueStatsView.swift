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
            let screenSize = UIScreen.main.bounds.size
            HStack {
                ForEach(viewModel.state.items) { item in
                    LeagueStatsItemView(item)
                        .frame(width: screenSize.width - 48)
                }
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 48 - 16))
        }
        .padding([.vertical], 16)
    }
}

struct LeagueStatsView_Previews: PreviewProvider {
    static var previews: some View {
        LeagueStatsView(LeagueStatsViewModel())
    }
}
