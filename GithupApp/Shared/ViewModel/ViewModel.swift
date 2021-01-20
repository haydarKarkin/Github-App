//
//  ViewModel.swift
//  GithupApp
//
//  Created by Haydar Karkin on 20.01.2021.
//

import Foundation

typealias ViewModelType = ViewModel & ViewModelTransformType

protocol ViewModelTransformType: class {
    
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input, output: @escaping(Output) -> ())
}

class ViewModel: NSObject {
    
    var onErrorHandling : ((Error?) -> Void)?
    var onLoadHandling : ((Bool) -> Void)?
    
    override init() {
        super.init()
    }
}
