//
//  UserAPI.swift
//  GithupApp
//
//  Created by Haydar Karkin on 23.01.2021.
//

import Foundation

enum UserAPI {
    case user(name: String)
    case userRepos(name: String)
}

extension UserAPI: TargetType {
    var baseURL: String {
        return Environment.rootURL.absoluteString
    }
    
    var path: String {
        switch self {
            case .user(let name):
                return "/users/\(name)"
            case .userRepos(let name):
                return "/users/\(name)/repos"
        }
    }
    
    var parameters: [String: Any]? {
        return [:]
    }
    
    var method: TargetMethod {
        switch self {
            case .user, .userRepos:
                return .get
        }
    }
}

// MARK: - Sample Data
extension UserAPI {
    enum SampleDataType: String {
        case UserProfileResponse
        case UserReposResponse
        
        var fileName: String {
            return self.rawValue
        }
    }
    
    var sampleData: Data {
        switch self {
            case .user: return stubbedResponse(SampleDataType.UserProfileResponse.fileName)
            case .userRepos: return stubbedResponse(SampleDataType.UserReposResponse.fileName)
        }
    }
}
