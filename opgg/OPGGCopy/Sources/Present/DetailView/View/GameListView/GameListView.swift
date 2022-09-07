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
        LazyVStack(alignment: .leading, spacing: 3) {
            ForEach(viewModel.state.viewModels) { model in
                GameListItemView(model)
                    .frame(minHeight: self.rowHeight)
                    .listRowInsets(.init())
                    .background(
                        GeometryReader { proxy  in
                            Color.clear.preference(key: SizePreferenceKey.self, value: proxy.size)
                        }
                    )
                    .onPreferenceChange(SizePreferenceKey.self) { preferences in
                        let currentSize: CGSize = preferences
                        if currentSize.height > self.rowHeight {
                            self.rowHeight = currentSize.height
                        }
                    }
                    .onAppear {
                        if model.index == viewModel.state.viewModels.count - 1 {
                            viewModel.action.loadMore.send(())
                        }
                    }
            }
        }
        .background(Color.grey243)
    }
}

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue = CGSize.zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) { }
}

struct GameListView_Previews: PreviewProvider {
    static var previews: some View {
        GameListView(GameListViewModel())
    }
}
