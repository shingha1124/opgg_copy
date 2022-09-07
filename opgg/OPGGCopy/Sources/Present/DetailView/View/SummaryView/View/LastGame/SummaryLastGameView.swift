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
        let winRate = viewModel.state.winRate
        VStack(alignment: .leading, spacing: 4) {
            LocalizedText(.summaryTitle, args: [winRate.total])
                .font(size: 12).bold()
                .color(.grey26)
                .fixedSize()
            
            Spacer().frame(height: 5)
            
            Text(String(format: "%.2f:1", summary.kda))
                .font(.system(size: 14).weight(.bold))
                .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                .foregroundColor(.white)
                .background(summary.kdaColor)
                .clipShape(RoundedRectangle(cornerRadius: 5))
            
            let winRateText = "\(Int(round(winRate.rate)))%"
            let winRateColor = winRate.rateColor.hexColor
            LocalizedText(.winRate, args: [winRateColor, winRateText])
                .font(size: 14)
                .color(.grey26)
                .fixedSize()
            
            HStack(spacing: 0) {
                Text("KDA ")
                    .font(.system(size: 14))
                    .foregroundColor(.grey26)
                
                Group {
                    Text(String(format: "%.1f / ", summary.killRate))
                        .foregroundColor(.grey26) +
                    Text(String(format: "%.1f", summary.deathRate))
                        .foregroundColor(.red229) +
                    Text(String(format: " / %.1f", summary.assistRate))
                        .foregroundColor(.grey26)
                }
                .font(.system(size: 14).bold())
                .lineLimit(1)
                .fixedSize()
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
