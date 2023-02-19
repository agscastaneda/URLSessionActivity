//
//  HTTPURLResponse+ResponseCodes.swift
//  URLSessionSample
//
//  Created by Victor Pacheco on 19/02/23.
//

import Foundation

extension HTTPURLResponse {
    private static var ok200: Int { return 200 }
    private static var serverError: ClosedRange<Int> { return 500...599 }

    var isOK: Bool {
        return statusCode == HTTPURLResponse.ok200
    }
    
    var isServerError: Bool {
        switch statusCode {
        case HTTPURLResponse.serverError:
            return true
        default:
            return false
        }
    }
}
