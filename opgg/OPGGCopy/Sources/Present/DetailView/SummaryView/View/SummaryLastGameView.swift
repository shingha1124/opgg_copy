//
//  SummaryLastGameView.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/25.
//

import SwiftUI

struct SummaryLastGameView: View {
    
    @ObservedObject var viewModel: SummaryLastGameViewModel
    
    init(_ viewModel: SummaryLastGameViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("asdf")
        }
    }
}

struct SummaryLastGameView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryLastGameView(SummaryLastGameViewModel())
    }
}
