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
            Text(.Keys.playedWithTitle)
                .font(.system(size: 12).weight(.semibold))
                .foregroundColor(.black)
            
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
                        .font(.system(size: 11))
                        .lineLimit(1)
                        .fixedSize()
                    
                    let prefix = ParsedText(
                        key: .Keys.winRatePrefix,
                        color: Color.grey103.uiColor,
                        font: .systemFont(ofSize: 11))

                    let winRate = ParsedText(
                        text: String(format: "%.1f", viewModel.state.winRate.rate) + "%",
                        color: viewModel.state.winRate.rateColor.uiColor,
                        font: .systemFont(ofSize: 11, weight: .bold))
                    
                    IntegrateTextView(parsedTextList: [
                        prefix, winRate
                    ])
                    .fixedSize()
                }
                
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
