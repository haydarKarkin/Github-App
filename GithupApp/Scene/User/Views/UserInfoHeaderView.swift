//
//  UserInfoHeaderView.swift
//  GithupApp
//
//  Created by Haydar Karkin on 24.01.2021.
//

import UIKit

class UserInfoHeaderView: UITableViewHeaderFooterView, Reusable {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var publicReposLabel: UILabel!
    @IBOutlet weak var publicGistsLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    func configure(with model: UserModel) {
        avatarImageView.downloadImageFrom(link: model.avatarURL)
        let userType = String(describing: model.type ?? "User")
        userNameLabel.text = "\(userType) Name: \(String(describing: model.name ?? "none"))"
        mailLabel.text = "\(userType) Email: \(String(describing: model.email ?? "none"))"
        publicReposLabel.text = "\(userType) has \(String(model.publicRepos ?? 0)) public repos"
        publicGistsLabel.text = "\(userType) has \(String(model.publicGists ?? 0)) public gists"
        followersLabel.text = "\(userType) has \(String(model.followers ?? 0)) followers"
        followingLabel.text = "\(userType) follows \(String(model.following ?? 0)) User/Organizations"
        stackView.isHidden = false
    }
}
