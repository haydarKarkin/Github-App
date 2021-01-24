//
//  UserDetailVM.swift
//  GithupApp
//
//  Created by Haydar Karkin on 20.01.2021.
//

import Foundation

class UserDetailVM: ViewModelType {
    
    private var currentPage: Int = 1
    private var repos: [RepoModel] = [RepoModel]()
    private var userInfo: UserModel?
    
    private let userService: UserServiceType!
    private let owner: OwnerModel!
    
    init(userService: UserServiceType, owner: OwnerModel) {
        self.userService = userService
        self.owner = owner
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
        var next: (() -> Void)?
    }
    
    func transform(input: Input, output: @escaping(Output) -> ()) {
        
        let getUser: (() -> Void)? = {
            self.getUserInfo(completion: input.user)
        }
        
        let getRepos: (() -> Void)? = {
            self.getUserRepos(completion: input.repos)
        }
        
        let next: (() -> Void)? = {
            self.nextPage(completion: input.repos)
        }
        
        output(Output(getUser: getUser, getRepos: getRepos, next: next))
    }
}


// MARK: - Logics
extension UserDetailVM {
    
    func getUserInfo(completion: ((UserModel) -> Void)?) {
        self.onLoadHandling?(true)
        userService.getUser(name: owner.login!) { result in
            self.onLoadHandling?(false)
            switch result {
                case .success(let userInfo):
                    self.userInfo = userInfo
                    completion?(userInfo)
                case .failure(let error):
                    self.onErrorHandling?(error)
            }
        }
    }
    
    func getUserRepos(page: Int = 1, completion: (([RepoModel]) -> Void)?) {
        self.onLoadHandling?(true)
        
        currentPage = page
        userService.getUserRepos(name: owner.login!, page: page) { result in
            self.onLoadHandling?(false)
            switch result {
                case .success(let userRepos):
                    self.repos = self.repos + userRepos
                    completion?(self.repos)
                case .failure(let error):
                    self.onErrorHandling?(error)
            }
        }
    }
    
    func nextPage(completion: (([RepoModel]) -> Void)?) {
        
        guard let userInfo = userInfo else {
            return
        }
        
        if repos.count < userInfo.publicRepos ?? 0 {
            let nextPage = currentPage + 1
            getUserRepos(page: nextPage, completion: completion)
        }
    }
}
