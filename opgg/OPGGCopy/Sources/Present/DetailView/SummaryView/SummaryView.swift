//
//  SummaryView.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/25.
//

import SwiftUI

struct SummaryView: View {
    
    @ObservedObject var viewModel: SummaryViewModel
    
    private let lastGameView: SummaryLastGameView
    
    init(_ viewModel: SummaryViewModel) {
        self.viewModel = viewModel
        lastGameView = SummaryLastGameView(viewModel.viewModels.lastGame)
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Text("asdf").foregroundColor(.black)
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        }
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView(SummaryViewModel())
    }
}
