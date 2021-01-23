//
//  SearchRepoModel.swift
//  GithupApp
//
//  Created by Haydar Karkin on 20.01.2021.
//

import Foundation

// MARK: - SearchRepoModel
struct SearchRepoModel: Codable {
    let totalCount: Int?
    let incompleteResults: Bool?
    let repos: [RepoModel]?
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case repos = "items"
    }
}
