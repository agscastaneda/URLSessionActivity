//
//  CatsEndpoint.swift
//  URLSessionSample
//
//  Created by Victor Pacheco on 18/02/23.
//

import Foundation

struct CatsEndpoint: Endpoint {
    let baseURL: URL = animalsAPIBaseURL
    
    let path: String = "/v2/cats"
    
    var queryItems: [URLQueryItem] = []
}
