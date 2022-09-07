//
//  GameListItemView.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/28.
//

import SwiftUI

struct GameListItemView: View {
    
    @ObservedObject private var viewModel: GameListItemViewModel
    @State var rowHeight: CGFloat = 0
    
    private let summonerView: GameItemSummonerView
    private let itemsView: SummonerItemsView
    
    init(_ viewModel: GameListItemViewModel) {
        self.viewModel = viewModel
        summonerView = GameItemSummonerView(viewModel.viewModels.summoner)
        itemsView = SummonerItemsView(viewModel.viewModels.items)
    }
    
    var body: some View {
        HStack(spacing: 0) {
            let result = viewModel.state.gameResult
            VStack(spacing: 4) {
                LocalizedText(result == .win ? .win : .lose)
                    .font(size: 14).bold()
                    .color(.white)
                    .frame(alignment: .center)
                    .fixedSize()
                
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 16, height: 1)
                
                let gameLength = viewModel.state.gameLength
                let playTimeMin = String(format: "%02d", gameLength / 60)
                let playTimeSec = String(format: "%02d", gameLength % 60)
                Text("\(playTimeMin):\(playTimeSec)")
                    .font(.system(size: 12))
                    .foregroundColor(.white)
            }
            .frame(width: 45)
            .frame(maxHeight: .infinity)
            .background(result.color)
            .padding(0)
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 10) {
                    summonerView
                    itemsView
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 0) {
                    Text(viewModel.state.gameType.localizeKey.value)
                        .font(.system(size: 13))
                        .foregroundColor(.grey130)
                    
                    let createAt = viewModel.state.createAt?.createDateToValue ?? ""
                    Text(createAt)
                        .font(.system(size: 13))
                        .foregroundColor(.grey130)
                    
                    Spacer()
                    
                    Text("멀티킬")
                        .foregroundColor(.black)
                }
                .frame(maxHeight: .infinity)
                .padding(0)
            }
            .padding(16)
        }
        .background(Color.white)
    }
}

//struct GameListItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameListItemView(GameListItemViewModel())
//    }
//}
