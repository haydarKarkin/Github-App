//
//  UserDetailVC.swift
//  GithupApp
//
//  Created by Haydar Karkin on 20.01.2021.
//

import UIKit

class UserDetailVC: ViewController<UserDetailVM> {
    
    // VM Binders
    var getUserClosure: (() -> Void)?
    var getReposClosure: (() -> Void)?
    
    // Variables
    var repos: [RepoModel] = [RepoModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func makeUI() {
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let userInfoClosure: ((UserModel) -> Void)? = { [weak self] (result) in
            // TODO: - Update UI elements that are related with User
        }
        
        let reposClosure: (([RepoModel]) -> Void)? = { [weak self] (result) in
            // TODO: - Update UI elements that are related with User's Repos
        }
        
        let input = UserDetailVM.Input(user: userInfoClosure, repos: reposClosure)
        
        viewModel.transform(input: input){ (output) in
            self.getUserClosure = output.getUser
            self.getReposClosure = output.getRepos
        }
        
        // Load user's info and repos
        getUserClosure?()
        getReposClosure?()
    }
}

// MARK: - Storyboarded
extension UserDetailVC: Storyboarded {
    static var storyboardName = StoryboardName.user
}
