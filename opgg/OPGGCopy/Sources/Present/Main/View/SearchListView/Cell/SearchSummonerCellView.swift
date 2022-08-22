//
//  SearchSummonerCellView.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/22.
//

import SwiftUI

struct SearchSummonerCellView: View {
    
    @ObservedObject private var viewModel: SearchSummonerCellViewModel
    
    init(_ viewModel: SearchSummonerCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            AsyncImage(url: viewModel.state.profileImageURL) { $0.resizable() } placeholder: {
                Color.paleGrey2
            }
            .frame(width: 40, height: 40)
            .clipShape(Capsule())
            
            VStack(alignment: .leading, spacing: 5) {
                Text(viewModel.state.name)
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                    .foregroundColor(.systemDarkgrey)
                
                Text(viewModel.state.tierText)
                    .font(.system(size: 10))
                    .fontWeight(.regular)
                    .foregroundColor(.systemDarkgrey)
            }
            Spacer()
        }
        .contentShape(Rectangle())
    }
}

struct SearchSummonerCellView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SearchSummonerCellViewModel(PreviewMockData.shard.searchSummoner)
        SearchSummonerCellView(viewModel)
    }
}
