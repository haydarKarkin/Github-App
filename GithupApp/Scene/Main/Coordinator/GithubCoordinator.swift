//
//  GithubCoordinator.swift
//  GithupApp
//
//  Created by Haydar Karkin on 20.01.2021.
//

import Foundation
import UIKit

protocol GithubCoordinatorType: Coordinator {
    func goToUserDetailScene()
    func goToRepoDetailScene()
}

class GithubCoordinator: GithubCoordinatorType {
    private let navigationController: UINavigationController
    private let githubFactory: GithubFactoryType
    
    init(navigationController: UINavigationController, githubFactory: GithubFactoryType) {
        self.navigationController = navigationController
        self.githubFactory = githubFactory
    }
    
    func start() {
        let viewController = githubFactory.makeSearchRepoVC()
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func goToUserDetailScene() {
        let viewController = githubFactory.makeUserDetailVC()
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func goToRepoDetailScene() {
        let viewController = githubFactory.makeRepoDetailVC()
        navigationController.pushViewController(viewController, animated: false)
    }
}
