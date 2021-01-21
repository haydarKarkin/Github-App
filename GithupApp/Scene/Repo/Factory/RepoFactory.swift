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
    func makeRepoDetailVM() -> RepoDetailVM
    func makeSearchRepoVM() -> SearchRepoVM
    func makeRepoDetailVC() -> RepoDetailVC
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
        return RepoService()
    }
    
    func makeRepoDetailVM() -> RepoDetailVM {
        return RepoDetailVM()
    }
    
    func makeSearchRepoVM() -> SearchRepoVM {
        return SearchRepoVM()
    }
    
    func makeRepoDetailVC() -> RepoDetailVC {
        let viewController = RepoDetailVC.instantiate()
        viewController.viewModel = makeRepoDetailVM()
        return viewController
    }
    
    func makeSearchRepoVC() -> SearchRepoVC {
        let viewController = SearchRepoVC.instantiate()
        viewController.viewModel = makeSearchRepoVM()
        return viewController
    }
}
