//
//  UserFactory.swift
//  GithupApp
//
//  Created by Haydar Karkin on 21.01.2021.
//

import Foundation
import UIKit

protocol UserFactoryType {
    func makeUserCoordinator(navigationController: UINavigationController) -> UserCoordinatorType
    func makeUserService() -> UserServiceType
    func makeUserDetailVM() -> UserDetailVM
    func makeUserDetailVC() -> UserDetailVC
}

class UserFactory: UserFactoryType {
    
    let sharedFactory: SharedFactoryType!
    
    init(sharedFactory: SharedFactoryType) {
        self.sharedFactory = sharedFactory
    }
    
    func makeUserCoordinator(navigationController: UINavigationController) -> UserCoordinatorType {
        return UserCoordinator(navigationController: navigationController, userFactory: self)
    }
    
    func makeUserService() -> UserServiceType {
        let clientProvider: ClientProvider<UserAPI> = sharedFactory.makeClientProvider()
        return UserService(provider: clientProvider)
    }
    
    func makeUserDetailVM() -> UserDetailVM {
        return UserDetailVM()
    }
    
    func makeUserDetailVC() -> UserDetailVC {
        let viewController = UserDetailVC.instantiate()
        viewController.viewModel = makeUserDetailVM()
        return viewController
    }
}
