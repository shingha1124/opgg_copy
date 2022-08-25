//
//  PreviousSeasonsItemView.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/22.
//

import SwiftUI

struct PreviousSeasonsItemView: View {
    
    @ObservedObject var viewModel: PreviousSeasonsItemViewModel
    
    init(_ viewModel: PreviousSeasonsItemViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(spacing: 3) {
            Text(viewModel.state.season)
                .font(.system(size: 10))
                .bold()
                .foregroundColor(.grey103)
            
            Text(viewModel.state.tier)
                .font(.system(size: 10))
                .foregroundColor(.grey103)
            
            Text("\(viewModel.state.division ?? 0)")
                .font(.system(size: 10))
                .foregroundColor(.grey103)
                .visibility(viewModel.state.division == nil ? .gone : .visible)
        }
        .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
        .background(Color.grey224)
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}

struct PreviousSeasonsItemView_Previews: PreviewProvider {
    static var previews: some View {
        PreviousSeasonsItemView(PreviousSeasonsItemViewModel(PreviewMockData.shard.previousSeason))
    }
}
