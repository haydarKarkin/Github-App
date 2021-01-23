//
//  UserFactory.swift
//  GithupApp
//
//  Created by Haydar Karkin on 21.01.2021.
//

import Foundation
import UIKit

protocol UserFactoryType {
    func makeUserCoordinator(navigationController: UINavigationController, owner: OwnerModel) -> UserCoordinatorType
    func makeUserService() -> UserServiceType
    func makeUserDetailVM(userService: UserServiceType, owner: OwnerModel) -> UserDetailVM
    func makeUserDetailVC(owner: OwnerModel) -> UserDetailVC
}

class UserFactory: UserFactoryType {
    
    let sharedFactory: SharedFactoryType!
    
    init(sharedFactory: SharedFactoryType) {
        self.sharedFactory = sharedFactory
    }
    
    func makeUserCoordinator(navigationController: UINavigationController, owner: OwnerModel) -> UserCoordinatorType {
        return UserCoordinator(navigationController: navigationController, userFactory: self, owner: owner)
    }
    
    func makeUserService() -> UserServiceType {
        let clientProvider: ClientProvider<UserAPI> = sharedFactory.makeClientProvider()
        return UserService(provider: clientProvider)
    }
    
    func makeUserDetailVM(userService: UserServiceType, owner: OwnerModel) -> UserDetailVM {
        return UserDetailVM(userService: userService, owner: owner)
    }
    
    func makeUserDetailVC(owner: OwnerModel) -> UserDetailVC {
        let service: UserServiceType = makeUserService()
        let viewController = UserDetailVC.instantiate()
        viewController.viewModel = makeUserDetailVM(userService: service, owner: owner)
        return viewController
    }
}
