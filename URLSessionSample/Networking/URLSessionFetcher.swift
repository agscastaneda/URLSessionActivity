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
    
    func fetchData<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void) {
        do {
            let request = try urlRequestFactory.make()
            
            // TODO: Handle server response errors.
            let dataTask = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
                guard let self = self, let data = data else { return completion(.failure(NetworkingServerErrors.dataNotFound)) }
                completion(Result {
                    try self.decodableResultAdapter.mapModel(data: data)
                })
            }
            
            dataTask.resume()
        } catch {
            completion(.failure(error))
        }
    }
}
