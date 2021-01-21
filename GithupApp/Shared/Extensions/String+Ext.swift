//
//  String+Ext.swift
//  GithupApp
//
//  Created by Haydar Karkin on 21.01.2021.
//

import Foundation

extension String {
    
    static func className(_ obj: AnyObject) -> String {
        return String(describing: obj.self).components(separatedBy: ".").last!
    }
    
    static func className(_ cls: AnyClass) -> String {
        return String(describing: cls).components(separatedBy: ".").last!
    }
}
