//
//  SummonerInfoView.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/22.
//

import SwiftUI

struct DetailTopView: View {
    
    @ObservedObject var viewModel: DetailTopViewModel
    private let summonerInfoView: SummonerInfoView
    
    init(_ viewModel: DetailTopViewModel) {
        self.viewModel = viewModel
        summonerInfoView = SummonerInfoView(viewModel)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            GeometryReader { geometry in
                let minY = geometry.frame(in: .global).minY
                let value = minY <= 0 ? 0 : minY
                let offsetValue = minY <= 0 ? 0 : -minY
                
                AsyncImage(url: URL(string: "https://t1.daumcdn.net/cfile/tistory/27321E3D56C318F10C")) { $0.resizable() } placeholder: {
                    Color.paleGrey2
                }
                .aspectRatio(contentMode: .fill)
                .frame(width: geometry.size.width, height: geometry.size.height + value)
                .clipped()
                .offset(y: offsetValue)
            }
            .frame(height: 150)
            .overlay(
                summonerInfoView, alignment: .bottomLeading
            )
        }
    }
}

struct DetailTopView_Previews: PreviewProvider {
    static var previews: some View {
        DetailTopView(DetailTopViewModel())
    }
}
