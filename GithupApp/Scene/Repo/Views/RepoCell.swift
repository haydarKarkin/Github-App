//
//  RepoCell.swift
//  GithupApp
//
//  Created by Haydar Karkin on 23.01.2021.
//

import UIKit

class RepoCell: UITableViewCell, Reusable {
    
    // UI Elements
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var repoNameLabel: UILabel!
    
    // Binders
    var openUserDetailClosure: ((RepoModel) -> Void)?
    
    // Variables
    var model: RepoModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleAvatarTap(_:)))
        avatarImageView.addGestureRecognizer(tap)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with model: RepoModel, openUserDetail: ((RepoModel) -> Void)?) {
        repoNameLabel.text = model.fullName
        userNameLabel.text = model.owner?.login
        avatarImageView.downloadImageFrom(link: model.owner?.avatarURL)
        
        openUserDetailClosure = openUserDetail
    }
    
    @objc func handleAvatarTap(_ sender: UITapGestureRecognizer) {
        if let repo = model {
            openUserDetailClosure?(repo)
        }
    }
}
