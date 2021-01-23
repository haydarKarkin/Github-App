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
    func makeSearchRepoVM(repoService: RepoServiceType) -> SearchRepoVM
    func makeRepoDetailVC(repoModel: RepoModel) -> RepoDetailVC
    func makeSearchRepoVC() -> SearchRepoVC
}

class RepoFactory: RepoFactoryType {
    
    let sharedFactory: SharedFactoryType!
    
    init(sharedFactory: SharedFactoryType) {
        self.sharedFactory = sharedFactory
    }
    
    func makeRepoCoordinator(navigationController: UINavigationController) -> RepoCoordinatorType {
        return RepoCoordinator(navigationController: navigationController, githubFactory: self)
    }
    
    func makeRepoService() -> RepoServiceType {
        let clientProvider: ClientProvider<RepoAPI> = sharedFactory.makeClientProvider()
        return RepoService(provider: clientProvider)
    }
    
    func makeRepoDetailVM(repoModel: RepoModel) -> RepoDetailVM {
        return RepoDetailVM(repoModel: repoModel)
    }
    
    func makeSearchRepoVM(repoService: RepoServiceType) -> SearchRepoVM {
        return SearchRepoVM(repoService: repoService)
    }
    
    func makeRepoDetailVC(repoModel: RepoModel) -> RepoDetailVC {
        let viewController = RepoDetailVC.instantiate()
        viewController.viewModel = makeRepoDetailVM(repoModel: repoModel)
        return viewController
    }
    
    func makeSearchRepoVC() -> SearchRepoVC {
        let service: RepoServiceType = makeRepoService()
        let viewController = SearchRepoVC.instantiate()
        viewController.viewModel = makeSearchRepoVM(repoService: service)
        return viewController
    }
}
