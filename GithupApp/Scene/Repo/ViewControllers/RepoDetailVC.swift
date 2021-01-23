//
//  RepoDetailVC.swift
//  GithupApp
//
//  Created by Haydar Karkin on 20.01.2021.
//

import UIKit

class RepoDetailVC: ViewController<RepoDetailVM> {
    
    // VM Binders
    var openUserDetailClosure:(() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func makeUI() {
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let repoDetailClosure: ((RepoModel) -> Void)? = { [weak self] (result) in
            // TODO: - Update UI elements that are related with Repo
        }
        
        let input = RepoDetailVM.Input(repoDetail: repoDetailClosure)
        
        viewModel.transform(input: input){ (output) in
            self.openUserDetailClosure = output.openUserDetail
        }
    }
}

// MARK: - Storyboarded
extension RepoDetailVC: Storyboarded {
    static var storyboardName = StoryboardName.repo
}
