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
    private let repoFactoryType: RepoFactoryType
    
    init(navigationController: UINavigationController, repoFactoryType: RepoFactoryType) {
        self.navigationController = navigationController
        self.repoFactoryType = repoFactoryType
    }
    
    func start() {
        let viewController = repoFactoryType.makeSearchRepoVC(repoCoordinator: self)
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func goToUserDetailScene() {
        // TODO: - Coordinate to user coordinator
    }
    
    func goToRepoDetailScene(repoModel: RepoModel) {
        let viewController = repoFactoryType.makeRepoDetailVC(repoModel: repoModel)
        navigationController.pushViewController(viewController, animated: false)
    }
}
