//
//  CustomNavigationBar.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/24.
//

import SwiftUI

struct CustomNavBar<Left, Center, Right>: View where Left: View, Center: View, Right: View {
    let left: () -> Left
    let center: () -> Center
    let right: () -> Right
    
    init(@ViewBuilder left: @escaping () -> Left, @ViewBuilder center: @escaping () -> Center, @ViewBuilder right: @escaping () -> Right) {
        self.left = left
        self.center = center
        self.right = right
    }
    
    var body: some View {
        ZStack {
            HStack {
                left()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }
            center()
                .frame(maxWidth: .infinity, alignment: .center)
            HStack {
                Spacer()
                right()
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .navigationBarHidden(true)
    }
}
