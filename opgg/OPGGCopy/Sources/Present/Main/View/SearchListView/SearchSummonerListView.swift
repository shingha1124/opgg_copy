//
//  SearchSummonerListView.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/22.
//

import SwiftUI

struct SearchSummonerListView: View {
    @Binding var summoners: [SearchSummonerCellViewModel]
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            ForEach($summoners) { viewModel in
                let detailViewModel = DetailViewModel(viewModel.state.summonerId.wrappedValue)
                NavigationLink(destination: DetailView(detailViewModel)) {
                    SearchSummonerCellView(viewModel.wrappedValue)
                    if let last = summoners.last?.state.name,
                       last != viewModel.wrappedValue.state.name {
                        Divider()
                    }
                }
            }
        }
        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        .background(Color.systemBackground2)
    }
}

struct SearchSummonerListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchSummonerListView(summoners: .constant([]))
    }
}
