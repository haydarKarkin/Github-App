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
    func makeUserDetailVM(userService: UserServiceType, userName: String) -> UserDetailVM
    func makeUserDetailVC(userName: String) -> UserDetailVC
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
    
    func makeUserDetailVM(userService: UserServiceType, userName: String) -> UserDetailVM {
        return UserDetailVM(userService: userService, userName: userName)
    }
    
    func makeUserDetailVC(userName: String) -> UserDetailVC {
        let service: UserServiceType = makeUserService()
        let viewController = UserDetailVC.instantiate()
        viewController.viewModel = makeUserDetailVM(userService: service, userName: userName)
        return viewController
    }
}
