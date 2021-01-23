//
//  NetworkError.swift
//  GithupApp
//
//  Created by Haydar Karkin on 21.01.2021.
//

import Foundation

public enum NetworkError : String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
    case decodingFailed = "Can't read received data."
    case noNetwork = "Check your internet connection"
    case noOwner = "Could't find owner of the repo."
}
