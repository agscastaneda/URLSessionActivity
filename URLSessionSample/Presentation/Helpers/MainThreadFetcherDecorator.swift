//
//  MainThreadFetcherDecorator.swift
//  URLSessionSample
//
//  Created by Victor Pacheco on 18/02/23.
//

import Foundation

final class MainThreadFetcherDecorator: Fetcher {
    let fetcher: Fetcher
    
    init(fetcher: Fetcher) {
        self.fetcher = fetcher
    }
    
    func fetchData<T>(completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        fetcher.fetchData { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
