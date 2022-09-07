//
//  GameItemSummonerView.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/28.
//

import SwiftUI

struct GameItemSummonerView: View {
    @ObservedObject private var viewModel: GameItemSummonerViewModel
    @State var rowHeight: CGFloat = 0
    
    init(_ viewModel: GameItemSummonerViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(spacing: 0) {
            AsyncImage(url: viewModel.state.imageUrl) { $0.resizable() } placeholder: {
                Color.grey224
            }
            .squareRound(45)
            
            Spacer().frame(width: 5)
            
            VStack(spacing: 3) {
                AsyncImage(url: viewModel.state.spell1) { $0.resizable() } placeholder: {
                    Color.grey224
                }
                .squareRound(21)
                
                AsyncImage(url: viewModel.state.spell2) { $0.resizable() } placeholder: {
                    Color.grey224
                }
                .frame(width: 21, height: 21)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            Spacer().frame(width: 3)
            
            VStack(spacing: 3) {
                AsyncImage(url: viewModel.state.rune1) { $0.resizable() } placeholder: {
                    Color.grey224
                }
                .frame(width: 21, height: 21)
                .background(Color.grey26)
                .clipShape(Capsule())
                
                AsyncImage(url: viewModel.state.rune2) { $0.resizable() } placeholder: {
                    Color.grey224
                }
                .frame(width: 21, height: 21)
                .background(Color.grey224)
                .clipShape(Capsule())
            }
            
            Spacer().frame(width: 15)
            
            VStack(alignment: .leading, spacing: 5) {
                let gameSummary = viewModel.state.summary
                Group {
                    Text("\(gameSummary.kill) / ")
                        .foregroundColor(.grey26) +
                    Text("\(gameSummary.death)")
                        .foregroundColor(.red229) +
                    Text(" / \(gameSummary.assist)")
                        .foregroundColor(.grey26)
                }
                .font(.system(size: 20).bold())
                .lineLimit(1)
                .fixedSize()
                
                Text(String(format: LocalizedKey.killRate.value, "\(viewModel.state.killRate)%"))
                    .font(.system(size: 13))
                    .foregroundColor(.grey103)
                    .fixedSize()
            }
        }
        .padding(0)
    }
}

//struct GameItemSummonerView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameItemSummonerView(GameItemSummonerViewModel())
//    }
//}
