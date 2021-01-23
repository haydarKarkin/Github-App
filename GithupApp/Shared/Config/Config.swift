//
//  Config.swift
//  GithupApp
//
//  Created by Haydar Karkin on 20.01.2021.
//

import Foundation
import UIKit

struct Configs {
    struct Text {
        static let globalErrorTitle = "There is a problem!"
        static let globalErrorDesc = "Please try again later."
        static let searchPlaceHolder = "Type repo name here to search repos"
    }
    
    struct UI {
        static let estimatedRowHeight: CGFloat = 50.0
        static let placeholderImage = UIImage.init(named: "placeholder")
    }
    
    struct Network {
        static let paginationNumber: Int = 20
        static let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            return dateFormatter
        }()
        static let minCharForSearch: Int = 3
    }
}
