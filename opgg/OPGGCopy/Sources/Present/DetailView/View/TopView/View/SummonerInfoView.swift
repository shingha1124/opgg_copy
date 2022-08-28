//
//  DetailTopView.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/24.
//

import SwiftUI

struct SummonerInfoView: View {
    @ObservedObject var viewModel: DetailTopViewModel
    
    init(_ viewModel: DetailTopViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            AsyncImage(url: viewModel.state.imageUrl) { $0.resizable() } placeholder: {
                Color.paleGrey2
            }
            .frame(width: 75, height: 75)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .overlay(alignment: .bottom) {
                Text("\(viewModel.state.level)")
                    .font(.system(size: 13))
                    .padding(2)
                    .background(Color.grey44)
                    .clipShape(Capsule())
                    .offset(x: 0, y: 5)
            }
            
            Spacer().frame(width: 10)
            
            VStack(alignment: .leading, spacing: 2) {
                Spacer()
                Text(viewModel.state.name)
                    .font(.system(size: 25))
                    .bold()
                    .foregroundColor(.systemDarkgrey)
                
                let isRank = viewModel.state.rank != 0
                let args = viewModel.state.rank.currency()
                let localizedKey: LocalizedKey = isRank ? .ladderRank : .ladderRankEmpty
                
                LocalizedText(localizedKey, args: [args])
                    .font(size: 13)
                    .color(.grey130)
                    .fixedSize()
                
                Spacer()
            }
            Spacer()
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        .background(alignment: .bottom) {
            Rectangle()
                .fill(Color.clear)
                .frame(height: 100)
                .background(
                    LinearGradient(colors: [.grey26.opacity(1), .grey26.opacity(0)], startPoint: .bottom, endPoint: .top)
                )
        }
    }
}

struct SummonerInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SummonerInfoView(DetailTopViewModel())
    }
}
