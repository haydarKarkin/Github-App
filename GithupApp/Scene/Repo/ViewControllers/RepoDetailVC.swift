//
//  RepoDetailVC.swift
//  GithupApp
//
//  Created by Haydar Karkin on 20.01.2021.
//

import UIKit

class RepoDetailVC: ViewController<RepoDetailVM> {
    
    // UI Elements
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var ownerTypeLabel: UILabel!
    @IBOutlet weak var forkCountLabel: UILabel!
    @IBOutlet weak var defaultBranchLabel: UILabel!
    @IBOutlet weak var openIssuesLabel: UILabel!
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var licenseLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    // VM Binders
    var openUserDetailClosure:(() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func makeUI() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleAvatarTap(_:)))
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(tap)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let repoDetailClosure: ((RepoModel) -> Void)? = { [weak self] (result) in
            DispatchQueue.main.async {
                self?.stackView.isHidden = false
                self?.avatarImageView.downloadImageFrom(link: result.owner?.avatarURL)
                self?.repoNameLabel.text = result.name
                self?.descriptionLabel.text = "Description: \(result.repoDescription ?? "")"
                self?.ownerNameLabel.text = "Owner Name: \(result.owner?.login ?? "")"
                self?.ownerTypeLabel.text = "Owner Type: \(result.owner?.type?.rawValue ?? "")"
                self?.forkCountLabel.text = "Fork Count: \(String(result.forksCount ?? 0))"
                self?.defaultBranchLabel.text = "Default Branch: \(result.defaultBranch ?? "Main")"
                self?.openIssuesLabel.text = "Open Issues: \(String(result.openIssuesCount ?? 0))"
                self?.watchersLabel.text = "Watchers: \(String(result.watchersCount ?? 0))"
                self?.languageLabel.text = "Language: \(result.language ?? "Swift <3")"
                self?.licenseLabel.text = "License: \(result.license?.name ?? "none")"
            }
        }
        
        let input = RepoDetailVM.Input(repoDetail: repoDetailClosure)
        
        viewModel.transform(input: input){ (output) in
            self.openUserDetailClosure = output.openUserDetail
        }
    }
    
    @objc func handleAvatarTap(_ sender: UITapGestureRecognizer) {
        openUserDetailClosure?()
    }
}

// MARK: - Storyboarded
extension RepoDetailVC: Storyboarded {
    static var storyboardName = StoryboardName.repo
}
