//
//  ChampScoreView.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/25.
//

import SwiftUI

struct ChampScoreView: View {
    
    @ObservedObject var viewModel: ChampScoreViewModel
    
    init(_ viewModel: ChampScoreViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(key: .champScoreTitle)
                .font(.system(size: 12).weight(.semibold))
                .foregroundColor(.black)
            
            Spacer()
            
            HStack(spacing: 0) {
                let url = viewModel.state.champImageUrl
                AsyncImage(url: url, content: { $0.resizable() }, placeholder: { Color.grey130 })
                    .frame(width: 35, height: 35)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
                Spacer().frame(width: 4)
                
                VStack(alignment: .leading, spacing: 3) {
                    Text(viewModel.state.champName)
                        .foregroundColor(.grey26)
                        .font(.system(size: 12).bold())
                    
                    Text(key: .gameCount, args: [viewModel.state.playCount])
                        .foregroundColor(.grey103)
                        .font(.system(size: 12))
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

struct ChampScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ChampScoreView(ChampScoreViewModel())
    }
}
