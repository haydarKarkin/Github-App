//
//  Debounce.swift
//  GithupApp
//
//  Created by Haydar Karkin on 23.01.2021.
//

import Foundation

class Debounce<T: Equatable> {
    
    private init() {}
    
    static func input(_ input: T,
                      comparedAgainst current: @escaping @autoclosure () -> (T),
                      perform: @escaping (T) -> ()) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if input == current() { perform(input) }
        }
    }
}
