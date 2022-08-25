//
//  SearchSummonerListView.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/22.
//

import SwiftUI

struct SearchSummonerListView: View {
    @ObservedObject private var viewModel: SearchSummonerListViewModel
    
    init(_ viewModel: SearchSummonerListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            let items = viewModel.state.items
            
            ForEach(Array(zip(items.indices, items)), id: \.0) { index, itemViewModel in
                NavigationLink(destination: {
                    let viewModel = DetailViewModel(itemViewModel.state.summonerId)
                    NavigationLazyView(DetailView(DetailViewModel(itemViewModel.state.summonerId)))
                }, label: {
                    SearchSummonerCellView(itemViewModel)
                    
                    if index != items.count - 1 {
                        Divider()
                    }
                })
            }
        }
        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        .background(Color.systemBackground2)
    }
}

struct SearchSummonerListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchSummonerListView(SearchSummonerListViewModel())
    }
}
