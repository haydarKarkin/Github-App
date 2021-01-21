//
//  SearchRepoVC.swift
//  GithupApp
//
//  Created by Haydar Karkin on 20.01.2021.
//

import UIKit

class SearchRepoVC: ViewController<SearchRepoVM> {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func makeUI() {
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let input = SearchRepoVM.Input()
        viewModel.transform(input: input){ (output) in
        }
    }
}

// MARK: - Storyboarded
extension SearchRepoVC: Storyboarded {
    static var storyboardName = StoryboardName.repo
}
