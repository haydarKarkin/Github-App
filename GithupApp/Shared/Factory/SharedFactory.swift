//
//  SharedFactory.swift
//  GithupApp
//
//  Created by Haydar Karkin on 21.01.2021.
//

import UIKit

protocol SharedFactoryType {
    func makeRepoFactory() -> RepoFactoryType
    func makeUserFactory() -> UserFactoryType
}

class SharedFactory: SharedFactoryType {
    func makeRepoFactory() -> RepoFactoryType {
        return RepoFactory(sharedFactory: self)
    }
    
    func makeUserFactory() -> UserFactoryType {
        return UserFactory(sharedFactory: self)
    }
}
