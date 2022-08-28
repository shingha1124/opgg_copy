//
//  GameListView.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/28.
//

import SwiftUI

struct GameListView: View {
    
    @ObservedObject private var viewModel: GameListViewModel
    @State var rowHeight: CGFloat = 0
    
    init(_ viewModel: GameListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct GameListView_Previews: PreviewProvider {
    static var previews: some View {
        GameListView(GameListViewModel())
    }
}
