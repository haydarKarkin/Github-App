//
//  UserService.swift
//  GithupApp
//
//  Created by Haydar Karkin on 21.01.2021.
//

import Foundation

protocol UserServiceType {
    func getUser(name: String, completion: @escaping(Result<UserModel, Error>) -> ())
    func getUserRepos(name: String, page: Int, completion: @escaping(Result<[RepoModel], Error>) -> ())
}

class UserService: UserServiceType {
    
    let provider: ClientProvider<UserAPI>
    
    init(provider: ClientProvider<UserAPI>) {
        self.provider = provider
    }
    
    func getUser(name: String, completion: @escaping(Result<UserModel, Error>) -> ()) {
        provider.request(target: .user(name: name), responseType: UserModel.self) { result in
            switch result {
                case .success(let resp):
                    completion(.success(resp))
                case .failure(let error):
                    completion(.failure(error))
                    print(error.localizedDescription)
            }
        }
    }
    
    func getUserRepos(name: String, page: Int, completion: @escaping(Result<[RepoModel], Error>) -> ()) {
        provider.request(target: .userRepos(name: name,
                                            perPage: Configs.Network.paginationNumber,
                                            page: page),
                         responseType: [RepoModel].self) { result in
            switch result {
                case .success(let resp):
                    completion(.success(resp))
                case .failure(let error):
                    completion(.failure(error))
                    print(error.localizedDescription)
            }
        }
    }
}
