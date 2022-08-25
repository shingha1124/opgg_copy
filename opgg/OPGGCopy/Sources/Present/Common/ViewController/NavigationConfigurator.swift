//
//  NavigationConfigurator.swift
//  OPGGCopy
//
//  Created by seongha shin on 2022/08/24.
//

import SwiftUI

struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }
    var update: (UINavigationController) -> Void = { _ in }
    
    private let configuratorClass = NavigationConfiguratorClass()
    
    func makeUIViewController(context: Context) -> UIViewController {
        configuratorClass.configure = configure
        return configuratorClass
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if let navigationController = configuratorClass.navigation {
            update(navigationController)
        }
    }
}

private final class NavigationConfiguratorClass: UIViewController {
    var configure: (UINavigationController) -> Void = { _ in }
    var navigation: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.frame = .zero
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigation = self.navigationController
        if let navigationController = self.navigationController {
            configure(navigationController)
        }
    }
}

extension NavigationConfiguratorClass: UINavigationBarDelegate {
    
}
