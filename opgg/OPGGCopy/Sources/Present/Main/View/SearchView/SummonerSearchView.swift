//
//  SummonerSearchView.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/21.
//

import SwiftUI

struct SummonerSearchView: View {
    @ObservedObject var viewModel = SummonerSearchViewModel()
    
    @State private var searchText = "신싱하"
    
    init(_ viewModel: SummonerSearchViewModel) {
        self.viewModel = viewModel
    }
        
    var body: some View {
        HStack {
            HStack {
                Spacer().frame(width: 16)
                
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.coolGrey)
                
                TextField("소환사 이름 검색", text: $searchText)
                    .foregroundColor(.systemDarkgrey)
                    .frame(height: 40)
                    .background(Color.clear)
                    .border(.clear, width: 0)
                    .onChange(of: searchText, perform: {
                        viewModel.action.changedSearchText.send($0)
                    })
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.coolGrey, lineWidth: 1)
        )
        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        .background(Color.systemBackground2)
    }
}

struct SummonerSearchView_Previews: PreviewProvider {
    static var previews: some View {
        SummonerSearchView(SummonerSearchViewModel())
    }
}
