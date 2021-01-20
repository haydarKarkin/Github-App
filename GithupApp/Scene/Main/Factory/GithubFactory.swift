//
//  GithubFactory.swift
//  GithupApp
//
//  Created by Haydar Karkin on 20.01.2021.
//

import Foundation
import UIKit

protocol GithubFactoryType {
    func makeGithubCoordinator(navigationController: UINavigationController) -> GithubCoordinatorType
    func makeGithubService() -> GithubServiceType
    func makeRepoDetailVM() -> RepoDetailVM
    func makeSearchRepoVM() -> SearchRepoVM
    func makeUserDetailVM() -> UserDetailVM
    func makeRepoDetailVC() -> RepoDetailVC
    func makeSearchRepoVC() -> SearchRepoVC
    func makeUserDetailVC() -> UserDetailVC
}

class GithubFactory: GithubFactoryType {
    
    let sharedFactory: SharedFactoryType!
    
    init(sharedFactory: SharedFactoryType) {
        self.sharedFactory = sharedFactory
    }
    
    func makeGithubCoordinator(navigationController: UINavigationController) -> GithubCoordinatorType {
        return GithubCoordinator(navigationController: navigationController, githubFactory: self)
    }
    
    func makeGithubService() -> GithubServiceType {
        return GithubService()
    }
    
    func makeRepoDetailVM() -> RepoDetailVM {
        return RepoDetailVM()
    }
    
    func makeSearchRepoVM() -> SearchRepoVM {
        return SearchRepoVM()
    }
    
    func makeUserDetailVM() -> UserDetailVM {
        return UserDetailVM()
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
    
    func makeUserDetailVC() -> UserDetailVC {
        let viewController = UserDetailVC.instantiate()
        viewController.viewModel = makeUserDetailVM()
        return viewController
    }
}
