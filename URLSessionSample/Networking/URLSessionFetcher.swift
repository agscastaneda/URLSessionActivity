//
//  URLSessionFetcher.swift
//  URLSessionSample
//
//  Created by Victor Pacheco on 14/02/23.
//

import Foundation

final class URLSessionFetcher: Fetcher {
    
    private let urlRequestFactory: URLRequestFactory
    private let decodableResultAdapter: DecodableResultAdapter
    
    init(urlRequestFactory: URLRequestFactory, decodableResultAdapter: DecodableResultAdapter) {
        self.urlRequestFactory = urlRequestFactory
        self.decodableResultAdapter = decodableResultAdapter
    }
    
    @available(*, renamed: "fetchData()")
    func fetchData<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void) {
        do {
            let request = try urlRequestFactory.make()
            
            let dataTask = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
                completion(Result {
                    guard let self = self else { throw NetworkingClientErrors.lostReferenceSelf }
                    
                    if let error = error {
                        throw error
                    } else if let response = response as? HTTPURLResponse, response.isServerError {
                        throw NetworkingServerErrors.internalServerError
                    } else if let data = data, let response = response as? HTTPURLResponse, response.isOK {
                        return try self.decodableResultAdapter.mapModel(data: data)
                    } else {
                        throw NetworkingServerErrors.dataNotFound
                    }
                })
            }
            
            dataTask.resume()
        } catch {
            completion(.failure(error))
        }
    }
}

extension URLSessionFetcher: AsyncFetcher {
    func fetchData<T: Decodable>() async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            fetchData() { result in
                continuation.resume(with: result)
            }
        }
    }
}
