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
        HStack {
            AsyncImage(url: viewModel.state.tierImageUrl) { $0.resizable() } placeholder: { Color.darkishPink }
            .frame(width: 55, height: 55, alignment: .topLeading)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(viewModel.state.rankType)
                    .font(.system(size: 11))
                    .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                    .foregroundColor(.blue42)
                    .background(Color.blue237)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                
                Text(viewModel.state.tier)
                    .font(.system(size: 15))
                    .foregroundColor(.grey26)
                    .bold()
                
                let lpText = viewModel.state.lp.currency()
                Text("\(lpText) LP")
                    .font(.system(size: 11))
                    .foregroundColor(.grey103)
                    .bold()
                
                HStack(spacing: 3) {
                    let winRate = viewModel.state.winRate
                    Text(winRate.text)
                        .font(.system(size: 10))
                        .foregroundColor(.grey103)
                    
                    Text("(\(winRate.rate)%)")
                        .font(.system(size: 10))
                        .foregroundColor(.grey103)
                }
            }
            Spacer()
        }
        .padding(EdgeInsets(top: 16, leading: 12, bottom: 16, trailing: 12))
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.grey224, lineWidth: 1)
        }
    }
}

struct LeagueStatsItemView_Previews: PreviewProvider {
    static var previews: some View {
        LeagueStatsItemView(LeagueStatsItemViewModel(PreviewMockData.shard.leagueStats))
            .preferredColorScheme(.dark)
    }
}
