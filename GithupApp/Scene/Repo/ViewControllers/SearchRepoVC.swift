//
//  SearchRepoVC.swift
//  GithupApp
//
//  Created by Haydar Karkin on 20.01.2021.
//

import UIKit

class SearchRepoVC: ViewController<SearchRepoVM> {

    // VM Binders
    var nextClosure: (() -> Void)?
    var searchClosure: ((String) -> Void)?
    var openRepoDetailClosure: ((RepoModel) -> Void)?
    var openUserDetailClosure: ((RepoModel) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func makeUI() {
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let reposClosure: (([RepoModel]) -> Void)? = { [weak self] (result) in
            // TODO: - Update UI elements that are related with Repos
        }
        
        let input = SearchRepoVM.Input(repos: reposClosure)
        
        viewModel.transform(input: input){ (output) in
            self.searchClosure = output.search
            self.nextClosure = output.next
            self.openRepoDetailClosure = output.openRepoDetail
            self.openUserDetailClosure = output.openUserDetail
        }
    }
}

// MARK: - Storyboarded
extension SearchRepoVC: Storyboarded {
    static var storyboardName = StoryboardName.repo
}
