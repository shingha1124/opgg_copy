//
//  ContentView.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/21.
//

import SwiftUI

struct MainView: View {
    @State private var searchText = ""
        
    @ObservedObject var viewModel: MainViewModel
    
    private let searchView: SummonerSearchView
    private let searchListView: SearchSummonerListView
    
    init() {
        let viewModel = MainViewModel()
        self.viewModel = viewModel
        searchView = SummonerSearchView(viewModel.viewModels.searchSummoner)
        searchListView = SearchSummonerListView(viewModel.viewModels.searchList)
    }
    
    var body: some View {
        VStack {
            MainTopView()
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    searchView
                    
                    searchListView
                        .visibility(viewModel.state.searchListVisibilty)
                    
                    Spacer()
                }
            }
            .background(Color.systemBackground1)
        }
        .padding(0)
        .background(Color.systemBackground2)
        .navigationBarHidden(true)
        .preferredColorScheme(.dark)
        .navigationTitle("")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environment(\.colorScheme, .light)
    }
}
