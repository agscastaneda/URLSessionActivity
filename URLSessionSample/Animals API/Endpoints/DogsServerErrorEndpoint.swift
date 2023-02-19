//
//  DogsServerErrorEndpoint.swift
//  URLSessionSample
//
//  Created by Victor Pacheco on 19/02/23.
//

import Foundation

struct DogsServerErrorEndpoint: Endpoint {
    let baseURL: URL = animalsAPIBaseURL
    
    let path: String = "/v2/dogs/error"
    
    var queryItems: [URLQueryItem] = []
}
