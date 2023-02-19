//
//  CatsEmptyEndpoint.swift
//  URLSessionSample
//
//  Created by Victor Pacheco on 19/02/23.
//

import Foundation


struct CatsEmptyEndpoint: Endpoint {
    let baseURL: URL = animalsAPIBaseURL
    
    let path: String = "/v2/cats/empty"
    
    var queryItems: [URLQueryItem] = []
}
