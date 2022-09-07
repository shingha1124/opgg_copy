//
//  SummonerItemsView.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/28.
//

import SwiftUI

struct SummonerItemsView: View {
    @ObservedObject private var viewModel: SummonerItemsViewModel
    @State var rowHeight: CGFloat = 0
    
    init(_ viewModel: SummonerItemsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(spacing: 3) {
            ForEach(viewModel.state.items, id: \.index) { item in
                AsyncImage(url: item.item?.imageURL) { $0.resizable() } placeholder: {
                    Color.grey224
                }
                .squareRound(23)
            }
            
            AsyncImage(url: viewModel.state.trinketItem?.imageURL) { $0.resizable() } placeholder: {
                Color.grey224
            }
            .frame(width: 23, height: 23)
            .clipShape(Capsule())
        }
    }
}

//struct SummonerItemsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SummonerItemsView()
//    }
//}
