//
//  CatsServerErrorEndpoint.swift
//  URLSessionSample
//
//  Created by Victor Pacheco on 19/02/23.
//

import Foundation

struct CatsServerErrorEndpoint: Endpoint {
    let baseURL: URL = animalsAPIBaseURL
    
    let path: String = "/v2/cats/error"
    
    var queryItems: [URLQueryItem] = []
}
