//
//  DetailTopButtons.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/25.
//

import SwiftUI

struct DetailTopButtons: View {
    @ObservedObject var viewModel: DetailTopViewModel
    
    init(_ viewModel: DetailTopViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            Button(action: {
            }, label: {
                LocalizedText(.update)
                    .font(size: 13).bold()
                    .color(.white)
                    .fixedSize()
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.blue42)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            
            Button(action: {
            }, label: {
                LocalizedText(.inGame)
                    .font(size: 13).bold()
                    .color(.white)
                    .fixedSize()
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.grey83)
            .clipShape(RoundedRectangle(cornerRadius: 6))
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: 45)
        .padding(EdgeInsets(top: 20, leading: 16, bottom: 10, trailing: 16))
        .background(Color.grey26)
    }
}

struct DetailTopButtons_Previews: PreviewProvider {
    static var previews: some View {
        DetailTopButtons(DetailTopViewModel())
    }
}
