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
            .frame(width: 64, height: 64, alignment: .topLeading)
            .clipShape(RoundedRectangle(cornerRadius: 32))
            .foregroundColor(.black)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(viewModel.state.rankType)
                    .font(.system(size: 12))
                    .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                    .foregroundColor(.blue2)
                    .background(Color.blue2.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                
                Text(viewModel.state.tier)
                    .font(.system(size: 18))
                    .foregroundColor(.systemDarkgrey)
                    .bold()
                
                let lpText = viewModel.state.lp.currency()
                Text("\(lpText) LP")
                    .font(.system(size: 12))
                    .foregroundColor(.steelGrey)
                    .bold()
                
                HStack(spacing: 3) {
                    let winRate = viewModel.state.winRate
                    Text("\(winRate.wins)승 \(winRate.losses)패")
                        .font(.system(size: 10))
                        .foregroundColor(.steelGrey)
                    
                    Text("(\(winRate.rate)%)")
                        .font(.system(size: 10))
                        .foregroundColor(.steelGrey)
                }
            }
            Spacer()
        }
        .padding(EdgeInsets(top: 16, leading: 12, bottom: 16, trailing: 12))
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.charcoalGrey, lineWidth: 1)
        }
    }
}

struct LeagueStatsItemView_Previews: PreviewProvider {
    static var previews: some View {
        LeagueStatsItemView(LeagueStatsItemViewModel(PreviewMockData.shard.leagueStats))
            .preferredColorScheme(.dark)
    }
}
