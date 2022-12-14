//
//  SummaryLastGameView.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/25.
//

import SwiftUI

struct MostChampionView: View {
    
    @ObservedObject var viewModel: MostChampionViewModel
    
    init(_ viewModel: MostChampionViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("most")
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
                        .font(.system(size: 11))
                    
                    Text("asd")
                        .foregroundColor(.grey103)
                        .font(.system(size: 11))
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

struct MostChampionView_Previews: PreviewProvider {
    static var previews: some View {
        MostChampionView(MostChampionViewModel())
    }
}
