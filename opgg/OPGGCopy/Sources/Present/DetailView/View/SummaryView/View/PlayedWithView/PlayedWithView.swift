//
//  PlayedWithView.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/25.
//

import SwiftUI

struct PlayedWithView: View {
    
    @ObservedObject var viewModel: PlayedWithViewModel
    
    init(_ viewModel: PlayedWithViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            LocalizedText(.playedWithTitle)
                .font(size: 12).bold()
                .color(.grey26)
                .fixedSize()
            
            Spacer()
            
            HStack(spacing: 0) {
                let url = viewModel.state.profileImageURL
                AsyncImage(url: url, content: { $0.resizable() }, placeholder: { Color.grey130 })
                    .frame(width: 35, height: 35)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
                Spacer().frame(width: 4)
                
                VStack(alignment: .leading, spacing: 3) {
                    Text(viewModel.state.name)
                        .foregroundColor(.grey26)
                        .font(.system(size: 12))
                        .lineLimit(1)
                        .fixedSize()
                    
                    let winRate = viewModel.state.winRate
                    let winRateTextValue = String(format: "%.1f", winRate.rate)
                    let winRateText = "\(winRateTextValue)%"
                    let winRateColor = winRate.rateColor.hexColor
                    LocalizedText(.winRate, args: [winRateColor, winRateText])
                        .font(size: 12)
                        .color(.grey103)
                        .fixedSize()
                }.fixedSize(horizontal: true, vertical: false)
                
                Image(systemName: "chevron.right")
                    .frame(width: 35, height: 35)
                    .foregroundColor(.grey130)
            }
        }
        .padding(EdgeInsets(top: 16, leading: 12, bottom: 16, trailing: 12))
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.grey224, lineWidth: 1)
        }
    }
}

struct PlayedWithView_Previews: PreviewProvider {
    static var previews: some View {
        PlayedWithView(PlayedWithViewModel())
    }
}
