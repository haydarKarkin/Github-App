//
//  AppCoordinator.swift
//  GithupApp
//
//  Created by Haydar Karkin on 20.01.2021.
//

import UIKit

class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    private let sharedFactory: SharedFactoryType
    
    init(window: UIWindow, sharedFactory: SharedFactoryType) {
        self.window = window
        self.sharedFactory = sharedFactory
    }
    
    func start() {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let coordinator = sharedFactory
            .makeGithubFactory()
            .makeGithubCoordinator(navigationController: navigationController)
        coordinate(to: coordinator)
    }
}
