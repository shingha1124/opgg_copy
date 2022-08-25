//
//  SummaryLastGameView.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/25.
//

import SwiftUI

struct SummaryLastGameView: View {
    
    @ObservedObject var viewModel: SummaryLastGameViewModel
    
    init(_ viewModel: SummaryLastGameViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View { 
        let summary = viewModel.state.gameSummary
        VStack(alignment: .leading, spacing: 4) {
            Text(String.localized(.Keys.summaryTitle, args: [summary.totalGameCount]))
                .font(.system(size: 12).weight(.semibold))
                .foregroundColor(.black)
            Spacer().frame(height: 5)
            Text(String(format: "%.2f:1", summary.kda))
                .font(.system(size: 13).weight(.bold))
                .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                .foregroundColor(.white)
                .background(summary.kdaRateColor)
                .clipShape(RoundedRectangle(cornerRadius: 5))
            
            let prefix = ParsedText(
                key: .Keys.winRatePrefix,
                color: Color.grey26.uiColor,
                font: .systemFont(ofSize: 13))

            let winRate = ParsedText(
                text: "\(summary.winRate)%",
                color: Color.grey26.uiColor,
                font: .systemFont(ofSize: 13, weight: .bold))

            let suffix = ParsedText(
                text: "%",
                color: Color.grey26.uiColor,
                font: .systemFont(ofSize: 13))
            
            IntegrateTextView(parsedTextList: [
                prefix, winRate, suffix
            ]).fixedSize()
            
            HStack(spacing: 0) {
                Text("KDA ")
                    .font(.system(size: 13))
                    .foregroundColor(.grey26)
                
                IntegrateTextView(parsedTextList: summary.kdaParsedTexts(13)).fixedSize()
            }
        }
        .padding(EdgeInsets(top: 16, leading: 12, bottom: 16, trailing: 12))
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.grey224, lineWidth: 1)
        }
    }
}

struct SummaryLastGameView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryLastGameView(SummaryLastGameViewModel())
    }
}
