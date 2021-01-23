//
//  RepoDetailVM.swift
//  GithupApp
//
//  Created by Haydar Karkin on 20.01.2021.
//

import Foundation

class RepoDetailVM: ViewModelType {
    
    private let repoModel: RepoModel!
    
    init(repoModel: RepoModel) {
        self.repoModel = repoModel
    }
}

// MARK: - VM I/O
extension RepoDetailVM {
    struct Input {
        let repoDetail: ((RepoModel) -> Void)?
    }
    
    struct Output {
        let openUserDetail:(() -> Void)?
    }
    
    func transform(input: Input, output: @escaping(Output) -> ()) {
        input.repoDetail?(repoModel)
        
        let openUserDetail:(() -> Void)? = {
            self.goToUserDetailScene()
        }
        
        output(Output(openUserDetail: openUserDetail))
    }
}


// MARK: - Logics
extension RepoDetailVM {
    func goToUserDetailScene() {
        // TODO: - Open user detail scene
    }
}
