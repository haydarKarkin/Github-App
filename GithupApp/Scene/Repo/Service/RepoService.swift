//
//  RepoService.swift
//  GithupApp
//
//  Created by Haydar Karkin on 20.01.2021.
//

import Foundation

protocol RepoServiceType {
    func search(query: String, page: Int, completion: @escaping(Result<[RepoModel], Error>) -> ())
}

class RepoService: RepoServiceType {
    
    let provider: ClientProvider<RepoAPI>
    
    init(provider: ClientProvider<RepoAPI>) {
        self.provider = provider
    }
    
    func search(query: String, page: Int, completion: @escaping(Result<[RepoModel], Error>) -> ()) {
        provider.request(target: .search(query: query,
                                         perPage: Configs.Network.paginationNumber,
                                         page: page),
                         responseType: SearchRepoModel.self) { result in
            
            switch result {
                case .success(let resp):
                    completion(.success(resp.repos ?? []))
                case .failure(let error):
                    completion(.failure(error))
                    print(error.localizedDescription)
            }
        }
    }
}
