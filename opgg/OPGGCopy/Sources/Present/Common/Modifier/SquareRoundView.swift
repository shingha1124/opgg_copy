//
//  RoundImageView.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/28.
//

import SwiftUI

struct SquareRoundView: ViewModifier {
    private let width: CGFloat
    
    init(_ width: CGFloat) {
        self.width = width
    }
    
  func body(content: Content) -> some View {
      content
          .frame(width: width, height: width)
          .clipShape(RoundedRectangle(cornerRadius: width / 2 - 4))
  }
}

extension View {
    func squareRound(_ width: CGFloat) -> some View {
        modifier(SquareRoundView(width))
    }
}
