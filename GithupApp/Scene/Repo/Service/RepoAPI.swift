//
//  RepoAPI.swift
//  GithupApp
//
//  Created by Haydar Karkin on 23.01.2021.
//

import Foundation

enum RepoAPI {
    case search(query: String, perPage: Int, page: Int)
}

extension RepoAPI: TargetType {
    var baseURL: String {
        return Environment.rootURL.absoluteString
    }
    
    var path: String {
        switch self {
            case .search:
                return "/search/repositories"
        }
    }
    
    var parameters: [String: Any]? {
        
        var params: [String: Any] = [:]
        
        switch self {
            case .search(let query, let perPage, let page):
                params["q"] = query
                params["per_page"] = perPage
                params["page"] = page
        }
        return params
    }
    
    var method: TargetMethod {
        switch self {
            case .search:
                return .get
        }
    }
}

// MARK: - Sample Data
extension RepoAPI {
    enum SampleDataType: String {
        case SearchRepoResponse
        
        var fileName: String {
            return self.rawValue
        }
    }
    
    var sampleData: Data {
        switch self {
            case .search: return stubbedResponse(SampleDataType.SearchRepoResponse.fileName)
        }
    }
}
