//
//  AsyncFetcher.swift
//  URLSessionSample
//
//  Created by Victor Pacheco on 18/02/23.
//

import Foundation

protocol AsyncFetcher {
    func fetchData<T: Decodable>() async throws -> T
}
