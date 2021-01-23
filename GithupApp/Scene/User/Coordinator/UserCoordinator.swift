//
//  UserCoordinator.swift
//  GithupApp
//
//  Created by Haydar Karkin on 21.01.2021.
//

import Foundation
import UIKit

protocol UserCoordinatorType: Coordinator {
}

class UserCoordinator: UserCoordinatorType {
    
    private let navigationController: UINavigationController
    private let userFactory: UserFactoryType
    private let owner: OwnerModel
    
    init(navigationController: UINavigationController, userFactory: UserFactoryType, owner: OwnerModel) {
        self.navigationController = navigationController
        self.userFactory = userFactory
        self.owner = owner
    }
    
    func start() {
        let viewController = userFactory.makeUserDetailVC(owner: owner)
        navigationController.pushViewController(viewController, animated: false)
    }
}
