//
//  DogsEmptyEndpoint.swift
//  URLSessionSample
//
//  Created by Victor Pacheco on 19/02/23.
//

import Foundation

struct DogsEmptyEndpoint: Endpoint {
    let baseURL: URL = animalsAPIBaseURL
    
    let path: String = "/v2/dogs/empty"
    
    var queryItems: [URLQueryItem] = []
}
