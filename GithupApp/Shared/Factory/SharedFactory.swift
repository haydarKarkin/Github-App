//
//  SharedFactory.swift
//  GithupApp
//
//  Created by Haydar Karkin on 21.01.2021.
//

import UIKit

protocol SharedFactoryType {
    func makeClientProvider<T: TargetType>(shouldStub: StubType) -> ClientProvider<T>
    func makeAsyncClientProvider<T: TargetType>(shouldStub: StubType) -> AsyncClientProvider<T>
    func makeRepoFactory() -> RepoFactoryType
    func makeUserFactory() -> UserFactoryType
}

extension SharedFactoryType {
    func makeClientProvider<T: TargetType>(shouldStub: StubType = .never) -> ClientProvider<T> {
        return makeClientProvider(shouldStub: shouldStub)
    }
    
    func makeAsyncClientProvider<T: TargetType>(shouldStub: StubType = .never) -> AsyncClientProvider<T> {
        return makeAsyncClientProvider(shouldStub: shouldStub)
    }
}

class SharedFactory: SharedFactoryType {
    func makeClientProvider<T: TargetType>(shouldStub: StubType) -> ClientProvider<T> {
        return ClientProvider<T>(shouldStub: shouldStub)
    }
    
    func makeAsyncClientProvider<T: TargetType>(shouldStub: StubType) -> AsyncClientProvider<T> {
        return AsyncClientProvider<T>(shouldStub: shouldStub)
    }
    
    func makeRepoFactory() -> RepoFactoryType {
        return RepoFactory(sharedFactory: self)
    }
    
    func makeUserFactory() -> UserFactoryType {
        return UserFactory(sharedFactory: self)
    }
}
