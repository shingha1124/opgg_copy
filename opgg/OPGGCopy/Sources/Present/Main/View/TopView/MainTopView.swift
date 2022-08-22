//
//  MainTopView.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/21.
//

import SwiftUI

struct MainTopView: View {
    var body: some View {
        HStack {
            Image("opgg")
                .resizable()
                .scaledToFit()
                .frame(height: 30)
            
            Spacer()
        }
        .padding(EdgeInsets(top: 24, leading: 16, bottom: 16, trailing: 16))
        .background(Color.systemBackground2)
    }
}

struct MainTopView_Previews: PreviewProvider {
    static var previews: some View {
        MainTopView()
    }
}
