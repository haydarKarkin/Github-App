//
//  UserDetailVC.swift
//  GithupApp
//
//  Created by Haydar Karkin on 20.01.2021.
//

import UIKit

class UserDetailVC: ViewController<UserDetailVM> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func makeUI() {
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let input = UserDetailVM.Input()
        viewModel.transform(input: input){ (output) in
        }
    }
}
