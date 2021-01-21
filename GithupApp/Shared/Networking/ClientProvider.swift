//
//  ClientProvider.swift
//  GithupApp
//
//  Created by Haydar Karkin on 21.01.2021.
//

import Foundation

enum StubType {
    case never
    case immediatelyStub
}

final class ClientProvider<T: TargetType> {
    private let urlSession = URLSession.shared
    private let cache = NSCache<NSString, NSData>()
    private let shouldStub: StubType
    
    init(shouldStub: StubType = .never) {
        self.shouldStub = shouldStub
    }
    
    func request<U>(target: T, responseType: U.Type, completion: @escaping (Result<U, Error>) -> Void) where U: Decodable {
        load(target) { result in
            switch result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    do {
                        let resp = try decoder.decode(responseType, from: data)
                        completion(.success(resp))
                    }
                    catch {
                        completion(.failure(NetworkError.decodingFailed))
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func download(target: T, completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = target.urlRequest.url?.absoluteString else {
            completion(.failure(NetworkError.missingURL))
            return
        }
        
        if target.cacheable {
            getCacheData(from: url) { data in
                completion(.success(data))
                return
            }
        }
        
        load(target) { [self] result in
            switch result {
                case .success(let data):
                    completion(.success(data))
                    
                    if target.cacheable {
                        self.setCacheData(with: url, data: data)
                    }
                    
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}

extension ClientProvider {
    private func load(_ target: T, deliverQueue: DispatchQueue = DispatchQueue.main, completion: @escaping (Result<Data, Error>) -> Void) {
        
        if shouldStub == .immediatelyStub {
            completion(.success(target.sampleData))
            return
        }
        
        urlSession.dataTask(with: target.urlRequest) { (data, _, error) in
            if let error = error {
                deliverQueue.async {
                    completion(.failure(error))
                }
            } else if let data = data {
                deliverQueue.async {
                    completion(.success(data))
                }
            }
        }.resume()
    }
    
    private func setCacheData(with key: String, data: Data) {
        cache.setObject(data as NSData, forKey: key as NSString)
    }
    
    private func getCacheData(from key: String, completion: @escaping (Data) -> Void) {
        let cacheID = NSString(string: key)
        
        if let cachedData = cache.object(forKey: cacheID) {
            completion(cachedData as Data)
        }
    }
}
