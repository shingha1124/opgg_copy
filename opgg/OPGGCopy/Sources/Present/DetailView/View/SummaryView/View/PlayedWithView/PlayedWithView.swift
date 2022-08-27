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
            Text(key: .playedWithTitle)
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
                    
//                    let winRate = String(format: "%.1f", viewModel.state.winRate.rate)
//                    let winRateText = "\(winRate)%"
//                    let localizedString = LocalizedKey.winRate.with(args: [winRateText])
//                    Text(localizedString.attributedToOption([
//                        AttributeOption(text: winRateText, options: [
//                            ColorOption(viewModel.state.winRate.rateColor),
//                            FontOption(.system(size: 11).bold())
//                        ])
//                    ]))
//                    .lineLimit(1)
//                    .foregroundColor(.grey103)
//                    .font(.system(size: 11))
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
