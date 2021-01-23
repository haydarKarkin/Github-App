//
//  UserDetailVM.swift
//  GithupApp
//
//  Created by Haydar Karkin on 20.01.2021.
//

import Foundation

class UserDetailVM: ViewModelType {
    
    private let userService: UserServiceType!
    private let userName: String!
    
    init(userService: UserServiceType, userName: String) {
        self.userService = userService
        self.userName = userName
    }
}

// MARK: - VM I/O
extension UserDetailVM {
    struct Input {
        let user: ((UserModel) -> Void)?
        let repos: (([RepoModel]) -> Void)?
    }
    
    struct Output {
        let getUser: (() -> Void)?
        let getRepos: (() -> Void)?
    }
    
    func transform(input: Input, output: @escaping(Output) -> ()) {
        
        let getUser: (() -> Void)? = {
            self.getUserInfo(completion: input.user)
        }
        
        let getRepos: (() -> Void)? = {
            self.getUserRepos(completion: input.repos)
        }
        
        output(Output(getUser: getUser, getRepos: getRepos))
    }
}


// MARK: - Logics
extension UserDetailVM {
    
    func getUserInfo(completion: ((UserModel) -> Void)?) {
        self.onLoadHandling?(true)
        userService.getUser(name: userName) { result in
            self.onLoadHandling?(false)
            switch result {
                case .success(let userInfo):
                    completion?(userInfo)
                case .failure(let error):
                    self.onErrorHandling?(error)
            }
        }
    }
    
    func getUserRepos(completion: (([RepoModel]) -> Void)?) {
        self.onLoadHandling?(true)
        userService.getUserRepos(name: userName) { result in
            self.onLoadHandling?(false)
            switch result {
                case .success(let userRepos):
                    completion?(userRepos)
                case .failure(let error):
                    self.onErrorHandling?(error)
            }
        }
    }
}
