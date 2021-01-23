//
//  UserRepoCell.swift
//  GithupApp
//
//  Created by Haydar Karkin on 24.01.2021.
//

import UIKit

class UserRepoCell: UITableViewCell, Reusable {

    @IBOutlet weak var repoNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with model: RepoModel) {
        repoNameLabel.text = model.fullName
    }
}
