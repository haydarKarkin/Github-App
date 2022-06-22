//
//  AsyncClientProvider.swift
//  GithupApp
//
//  Created by hkarkin on 22.06.2022.
//

import Foundation

final class AsyncClientProvider<T: TargetType> {
    private let urlSession = URLSession.shared
    private let cache = NSCache<NSString, NSData>()
    private let shouldStub: StubType
    
    init(shouldStub: StubType = .never) {
        self.shouldStub = shouldStub
    }
    
    func request<U>(target: T, responseType: U.Type) async throws -> U where U: Decodable {
        let data = try await load(target)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(Configs.Network.dateFormatter)
        do {
            let resp = try decoder.decode(responseType, from: data)
            return resp
        }
        catch {
            throw NetworkError.decodingFailed
        }
    }
}

extension AsyncClientProvider {
    private func load(_ target: T, deliverQueue: DispatchQueue = DispatchQueue.main) async throws -> Data {
        
        if shouldStub == .immediatelyStub {
            return target.sampleData
        }
        
        guard let url = target.urlRequest.url?.absoluteString else {
            throw NetworkError.missingURL
        }
        
        if target.cacheable {
            do {
                let data = try await getCacheData(from: url)
                return data
            } catch {
                // do nothing.
            }
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            urlSession.dataTask(with: target.urlRequest) { (data, _, error) in
                if let error = error {
                    deliverQueue.async {
                        continuation.resume(with: .failure(error))
                    }
                } else if let data = data {
                    deliverQueue.async {
                        continuation.resume(with: .success(data))
                    }
                }
            }.resume()
        }
    }
    
    private func setCacheData(with key: String, data: Data) {
        cache.setObject(data as NSData, forKey: key as NSString)
    }
    
    private func getCacheData(from key: String) async throws -> Data {
        let cacheID = NSString(string: key)
        
        if let cachedData = cache.object(forKey: cacheID) {
            return cachedData as Data
        }
        throw NetworkError.decodingFailed
    }
}
