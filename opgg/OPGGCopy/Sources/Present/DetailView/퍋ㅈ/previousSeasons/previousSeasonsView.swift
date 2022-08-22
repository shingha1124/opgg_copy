//
//  previousSeasonsView.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/22.
//

import SwiftUI

struct PreviousSeasonsView: View {
    
    @ObservedObject var viewModel: PreviousSeasonsViewModel
    
    init(_ viewModel: PreviousSeasonsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(viewModel.state.items) { item in
                    PreviousSeasonsItemView(item)
                }
            }
            .padding([.horizontal], 16)
        }
        .padding([.vertical], 16)
    }
}

struct PreviousSeasonsView_Previews: PreviewProvider {
    static var previews: some View {
        PreviousSeasonsView(PreviousSeasonsViewModel())
    }
}
