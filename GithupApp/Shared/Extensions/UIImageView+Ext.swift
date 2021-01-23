//
//  UIImageView+Ext.swift
//  GithupApp
//
//  Created by Haydar Karkin on 24.01.2021.
//

import UIKit

extension UIImageView {
    
    func downloadImageFrom(link: String?, contentMode: UIView.ContentMode = .scaleAspectFit) {
        
        guard let link = link,  let imgURL = URL(string: link) else {
            self.image = Configs.UI.placeholderImage
            return
        }
        
        URLSession.shared.dataTask(with: imgURL) { (data, _, error) in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                
                if let data = data {
                    self.image = UIImage(data: data)
                }
                
                if error != nil {
                    self.image = Configs.UI.placeholderImage
                }
            }
        }.resume()
    }
}
