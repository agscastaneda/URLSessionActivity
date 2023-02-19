//
//  Endpoint.swift
//  URLSessionSample
//
//  Created by Victor Pacheco on 18/02/23.
//

import Foundation

protocol Endpoint: URLRequestFactory {
    var baseURL: URL { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension Endpoint {
    func make() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = baseURL.scheme
        components.host = baseURL.host
        components.path = baseURL.path + path
        components.queryItems = queryItems.isEmpty ? nil : queryItems
        
        guard let url = components.url else {
            throw NetworkingClientErrors.invalidURL
        }
        return URLRequest(url: url)
    }
}
