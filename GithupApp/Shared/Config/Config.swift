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
    }
    
    struct UI {
        static let estimatedRowHeight: CGFloat = 50.0
    }
    
    struct Network {
        static let paginationNumber: Int = 20
        static let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            return dateFormatter
        }()
    }
}
