//
//  DogsEndpoint.swift
//  URLSessionSample
//
//  Created by Victor Pacheco on 18/02/23.
//

import Foundation

struct DogsEndpoint: Endpoint {
    let baseURL: URL = animalsAPIBaseURL
    
    let path: String = "/v2/dogs"
    
    var queryItems: [URLQueryItem] = []
}
