//
//  RepoDetailVC.swift
//  GithupApp
//
//  Created by Haydar Karkin on 20.01.2021.
//

import UIKit

class RepoDetailVC: ViewController<RepoDetailVM> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func makeUI() {
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let input = RepoDetailVM.Input()
        viewModel.transform(input: input){ (output) in
        }
    }
}

// MARK: - Storyboarded
extension RepoDetailVC: Storyboarded {
    static var storyboardName = StoryboardName.main
}
