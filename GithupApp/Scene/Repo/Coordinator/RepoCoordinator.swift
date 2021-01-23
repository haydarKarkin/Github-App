//
//  RepoCoordinator.swift
//  GithupApp
//
//  Created by Haydar Karkin on 20.01.2021.
//

import Foundation
import UIKit

protocol RepoCoordinatorType: Coordinator {
    func goToUserDetailScene()
    func goToRepoDetailScene(repoModel: RepoModel)
}

class RepoCoordinator: RepoCoordinatorType {
    private let navigationController: UINavigationController
    private let githubFactory: RepoFactoryType
    
    init(navigationController: UINavigationController, githubFactory: RepoFactoryType) {
        self.navigationController = navigationController
        self.githubFactory = githubFactory
    }
    
    func start() {
        let viewController = githubFactory.makeSearchRepoVC()
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func goToUserDetailScene() {
        // TODO: - Coordinate to user coordinator
    }
    
    func goToRepoDetailScene(repoModel: RepoModel) {
        let viewController = githubFactory.makeRepoDetailVC(repoModel: repoModel)
        navigationController.pushViewController(viewController, animated: false)
    }
}
