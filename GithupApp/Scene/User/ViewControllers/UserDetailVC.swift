//
//  UserDetailVC.swift
//  GithupApp
//
//  Created by Haydar Karkin on 20.01.2021.
//

import UIKit

class UserDetailVC: ViewController<UserDetailVM> {
    
    // UI Elements
    @IBOutlet weak var tableView: UITableView!
    
    // VM Binders
    var getUserClosure: (() -> Void)?
    var getReposClosure: (() -> Void)?
    var nextClosure: (() -> Void)?
    
    // Variables
    var repos: [RepoModel] = [RepoModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func makeUI() {
        
        // setup tableviewe
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.rowHeight = Configs.UI.estimatedRowHeight
        tableView.registerCellNib(UserRepoCell.self)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let userInfoClosure: ((UserModel) -> Void)? = { [weak self] (result) in
            // TODO: - Update UI elements that are related with User
        }
        
        let reposClosure: (([RepoModel]) -> Void)? = { [weak self] (result) in
            DispatchQueue.main.async {
                self?.repos = result
            }
        }
        
        let input = UserDetailVM.Input(user: userInfoClosure, repos: reposClosure)
        
        viewModel.transform(input: input){ (output) in
            self.getUserClosure = output.getUser
            self.getReposClosure = output.getRepos
            self.nextClosure = output.next
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

// MARK: - UITableViewDataSource
extension UserDetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UserRepoCell = tableView.dequeueReusableCell(indexPath: indexPath)
        cell.configure(with: repos[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension UserDetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let isReachedBottom = indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1
        
        if isReachedBottom {
            // TODO: - Call next page
        }
    }
}
