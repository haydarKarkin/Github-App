//
//  RepoFactory.swift
//  GithupApp
//
//  Created by Haydar Karkin on 20.01.2021.
//

import Foundation
import UIKit

protocol RepoFactoryType {
    func makeRepoCoordinator(navigationController: UINavigationController) -> RepoCoordinatorType
    func makeRepoService() -> RepoServiceType
    func makeRepoDetailVM(repoModel: RepoModel) -> RepoDetailVM
    func makeSearchRepoVM(repoService: RepoServiceType, repoCoordinator: RepoCoordinatorType) -> SearchRepoVM
    func makeRepoDetailVC(repoModel: RepoModel) -> RepoDetailVC
    func makeSearchRepoVC(repoCoordinator: RepoCoordinatorType) -> SearchRepoVC
}

class RepoFactory: RepoFactoryType {
    
    let sharedFactory: SharedFactoryType!
    
    init(sharedFactory: SharedFactoryType) {
        self.sharedFactory = sharedFactory
    }
    
    func makeRepoCoordinator(navigationController: UINavigationController) -> RepoCoordinatorType {
        return RepoCoordinator(navigationController: navigationController, repoFactoryType: self)
    }
    
    func makeRepoService() -> RepoServiceType {
        let clientProvider: ClientProvider<RepoAPI> = sharedFactory.makeClientProvider()
        return RepoService(provider: clientProvider)
    }
    
    func makeRepoDetailVM(repoModel: RepoModel) -> RepoDetailVM {
        return RepoDetailVM(repoModel: repoModel)
    }
    
    func makeSearchRepoVM(repoService: RepoServiceType, repoCoordinator: RepoCoordinatorType) -> SearchRepoVM {
        return SearchRepoVM(repoService: repoService, repoCoordinator: repoCoordinator)
    }
    
    func makeRepoDetailVC(repoModel: RepoModel) -> RepoDetailVC {
        let viewController = RepoDetailVC.instantiate()
        viewController.viewModel = makeRepoDetailVM(repoModel: repoModel)
        return viewController
    }
    
    func makeSearchRepoVC(repoCoordinator: RepoCoordinatorType) -> SearchRepoVC {
        let service: RepoServiceType = makeRepoService()
        let viewController = SearchRepoVC.instantiate()
        viewController.viewModel = makeSearchRepoVM(repoService: service, repoCoordinator: repoCoordinator)
        return viewController
    }
}
