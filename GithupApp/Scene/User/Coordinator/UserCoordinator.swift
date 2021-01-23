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
    
    init(navigationController: UINavigationController, userFactory: UserFactoryType) {
        self.navigationController = navigationController
        self.userFactory = userFactory
    }
    
    func start() {
        let viewController = userFactory.makeUserDetailVC(userName: "")
        navigationController.pushViewController(viewController, animated: false)
    }
}
