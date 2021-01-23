//
//  SearchRepoVM.swift
//  GithupApp
//
//  Created by Haydar Karkin on 20.01.2021.
//

import Foundation

class SearchRepoVM: ViewModelType {
    
    var searchQuery: String = ""
    var currentPage: Int = 1
    var repos: [RepoModel] = [RepoModel]()
    
    let repoService: RepoServiceType!
    
    init(repoService: RepoServiceType) {
        self.repoService = repoService
    }
}

// MARK: - VM I/O
extension SearchRepoVM {
    struct Input {
        var repos: (([RepoModel]) -> Void)?
    }
    
    struct Output {
        var next: (() -> Void)?
        var search: ((String) -> Void)?
        var openRepoDetail:((RepoModel) -> Void)?
        var openUserDetail:((RepoModel) -> Void)?
    }
    
    func transform(input: Input, output: @escaping(Output) -> ()) {
        
        let next: (() -> Void)? = {
            self.nextPage(completion: input.repos)
        }
        
        let search: ((String) -> Void)? = { query in
            self.search(query: query, completion: input.repos)
        }
        
        let openRepoDetail:((RepoModel) -> Void)? = { repo in
            self.goToRepoDetail(with: repo)
        }
        
        let openUserDetail:((RepoModel) -> Void)? = { repo in
            self.goToUserDetail(with: repo)
        }
        
        output(Output(next: next, search: search, openRepoDetail: openRepoDetail, openUserDetail: openUserDetail))
    }
}


// MARK: - Logics
extension SearchRepoVM {
    
    func search(query: String, page: Int = 1, completion: (([RepoModel]) -> Void)?) {
        self.onLoadHandling?(true)
        
        if searchQuery != query {
            repos = []
        }
        
        searchQuery = query
        currentPage = page
        
        repoService.search(query: query, page: page) { result in
            self.onLoadHandling?(false)
            switch result {
                case .success(let newRepos):
                    self.repos = self.repos + newRepos
                    
                    completion?(self.repos)
                case .failure(let error):
                    self.onErrorHandling?(error)
            }
        }
    }
    
    func nextPage(completion: (([RepoModel]) -> Void)?) {
        let nextPage = currentPage + 1
        search(query: searchQuery, page: nextPage, completion: completion)
    }
    
    func goToRepoDetail(with repo: RepoModel) {
        // TODO: - Open repo detail scene
    }
    
    func goToUserDetail(with repo: RepoModel) {
        // TODO: - Open user detail scene
    }
}
