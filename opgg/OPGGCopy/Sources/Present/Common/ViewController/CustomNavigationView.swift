//
//  CustomNavigationView.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/24.
//

import SwiftUI

struct CustomNavigationView<Content: View>: UIViewControllerRepresentable {
    private let gestureDelegateClass = GestureDelegateClass()
    private let navigationView = UINavigationController()
    
    var content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    func makeUIViewController(context: Context) -> UINavigationController {
        gestureDelegateClass.gestureRecognizerShouldBeginHandle = {
            navigationView.viewControllers.count > 1
        }
        
        let host = UIHostingController(rootView: content().environmentObject(navigationView))
        
        navigationView.viewControllers = [host]
        return navigationView
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        navigationView.interactivePopGestureRecognizer?.delegate = gestureDelegateClass
    }
}

private class GestureDelegateClass: NSObject, UIGestureRecognizerDelegate {
    
    var gestureRecognizerShouldBeginHandle: () -> Bool = { false }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        gestureRecognizerShouldBeginHandle()
    }
}

extension UINavigationController: ObservableObject {}
