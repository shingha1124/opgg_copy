//
//  NavigationLazyView.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/24.
//

import SwiftUI

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}
