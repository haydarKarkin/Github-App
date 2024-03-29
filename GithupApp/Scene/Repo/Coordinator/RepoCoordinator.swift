//
//  RepoCoordinator.swift
//  GithupApp
//
//  Created by Haydar Karkin on 20.01.2021.
//

import Foundation
import UIKit

protocol RepoCoordinatorType: Coordinator {
    func goToUserDetailScene(owner: OwnerModel)
    func goToRepoDetailScene(repoModel: RepoModel)
}

class RepoCoordinator: RepoCoordinatorType {
    private let navigationController: UINavigationController
    private let repoFactory: RepoFactoryType
    private let sharedFactory: SharedFactoryType
    
    init(navigationController: UINavigationController, repoFactory: RepoFactoryType, sharedFactory: SharedFactoryType) {
        self.navigationController = navigationController
        self.repoFactory = repoFactory
        self.sharedFactory = sharedFactory
    }
    
    func start() {
        let viewController = repoFactory.makeSearchRepoVC(repoCoordinator: self)
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func goToUserDetailScene(owner: OwnerModel) {
        let userCoordinator = sharedFactory
            .makeUserFactory()
            .makeUserCoordinator(navigationController: navigationController, owner: owner)
        coordinate(to: userCoordinator)
    }
    
    func goToRepoDetailScene(repoModel: RepoModel) {
        let viewController = repoFactory.makeRepoDetailVC(repoModel: repoModel, repoCoordinator: self)
        navigationController.pushViewController(viewController, animated: false)
    }
}
