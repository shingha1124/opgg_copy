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
            .frame(width: 88, height: 88)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            
            Spacer().frame(width: 10)
            
            VStack(alignment: .leading, spacing: 5) {
                Spacer()
                Text(viewModel.state.name)
                    .font(.system(size: 24))
                    .bold()
                    .foregroundColor(.systemDarkgrey)

                let prefix = ParsedText(
                    text: "래더 랭킹 ",
                    color: Color.steelGrey.uiColor,
                    font: .systemFont(ofSize: 13, weight: .regular))

                let rank = ParsedText(
                    text: viewModel.state.rank.isEmpty ? "-" : viewModel.state.rank,
                    color: Color.blue1.uiColor,
                    font: .systemFont(ofSize: 13, weight: .bold))

                let suffix = ParsedText(
                    text: viewModel.state.rank.isEmpty ? "" : "위",
                    color: Color.steelGrey.uiColor,
                    font: .systemFont(ofSize: 13, weight: .regular))

                IntegrateTextView(parsedTextList: [
                    prefix, rank, suffix
                ])
                Spacer()
            }
            .frame(height: 88)
        }
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 10, trailing: 16))
    }
}

struct SummonerInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SummonerInfoView(DetailTopViewModel())
    }
}
