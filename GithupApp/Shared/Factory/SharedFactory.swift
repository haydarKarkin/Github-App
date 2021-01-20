//
//  SharedFactory.swift
//  GithupApp
//
//  Created by Haydar Karkin on 21.01.2021.
//

import UIKit

protocol SharedFactoryType {
    func makeGithubFactory() -> GithubFactoryType
}

class SharedFactory: SharedFactoryType {
    func makeGithubFactory() -> GithubFactoryType {
        return GithubFactory(sharedFactory: self)
    }
}
