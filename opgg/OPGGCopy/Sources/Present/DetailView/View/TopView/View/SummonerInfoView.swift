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
                    .font(.system(size: 13).weight(.bold))
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

                let prefix = ParsedText(
                    key: .Keys.ladderRankPrefix,
                    color: Color.grey130.uiColor,
                    font: .systemFont(ofSize: 13, weight: .regular))

                let rank = ParsedText(
                    text: viewModel.state.rank.isEmpty ? "-" : viewModel.state.rank,
                    color: viewModel.state.rank.isEmpty ? Color.grey130.uiColor : Color.blue42.uiColor,
                    font: .systemFont(ofSize: 13, weight: .bold))

                let suffix = ParsedText(
                    key: viewModel.state.rank.isEmpty ? .Keys.emptyText : .Keys.ladderRankSuffix,
                    color: Color.grey130.uiColor,
                    font: .systemFont(ofSize: 13, weight: .regular))

                IntegrateTextView(parsedTextList: [
                    prefix, rank, suffix
                ]).fixedSize()
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
