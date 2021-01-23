//
//  SearchRepoVC.swift
//  GithupApp
//
//  Created by Haydar Karkin on 20.01.2021.
//

import UIKit

class SearchRepoVC: ViewController<SearchRepoVM> {

    // UI Elements
    @IBOutlet weak var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    // VM Binders
    var nextClosure: (() -> Void)?
    var searchClosure: ((String) -> Void)?
    var openRepoDetailClosure: ((RepoModel) -> Void)?
    var openUserDetailClosure: ((RepoModel) -> Void)?
    
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
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = Configs.UI.estimatedRowHeight
        tableView.registerCellNib(RepoCell.self)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let reposClosure: (([RepoModel]) -> Void)? = { [weak self] (result) in
            DispatchQueue.main.async {
                self?.repos = result
            }
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

// MARK: - UITableViewDataSource
extension SearchRepoVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RepoCell = tableView.dequeueReusableCell(indexPath: indexPath)
        cell.configure(with: repos[indexPath.row], openUserDetail: openUserDetailClosure)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchRepoVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openRepoDetailClosure?(repos[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let isReachedBottom = indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1
        
        if isReachedBottom && !searchController.isActive {
            nextClosure?()
        }
    }
}
