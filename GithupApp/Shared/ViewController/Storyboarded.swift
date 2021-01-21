//
//  Storyboarded.swift
//  GithupApp
//
//  Created by Haydar Karkin on 20.01.2021.
//

import Foundation
import UIKit

enum StoryboardName: String {
    case repo = "Repo"
    case user = "User"
}

protocol Storyboarded {
    static var storyboardName: StoryboardName { get }
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let identifier = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as! Self
        
        return viewController
    }
}
