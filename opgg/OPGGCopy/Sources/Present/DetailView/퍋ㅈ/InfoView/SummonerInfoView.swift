//
//  SummonerInfoView.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/22.
//

import SwiftUI

struct SummonerInfoView: View {
    
    @ObservedObject var viewModel: SummonerInfoViewModel
    
    init(_ viewModel: SummonerInfoViewModel) {
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
                    color: Color.softBlue.uiColor,
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
        }
        .padding(16)
    }
}

struct SummonerInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SummonerInfoView(SummonerInfoViewModel())
    }
}
