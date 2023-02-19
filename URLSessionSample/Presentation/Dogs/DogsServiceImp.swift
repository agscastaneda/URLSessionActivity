//
//  DogsServiceImp.swift
//  URLSessionSample
//
//  Created by Victor Pacheco on 16/02/23.
//

import Foundation

final class DogsServiceImp: DogsService {
    
    private let fetcher: AsyncFetcher
    
    init(fetcher: AsyncFetcher) {
        self.fetcher = fetcher
    }
    
    func getDogs() async throws -> [DogViewData] {
        let dogs: [Dog] = try await fetcher.fetchData()
        let presentableDogs = mapToViewData(dogs)
        return presentableDogs
    }
    
    func mapToViewData(_ dogs: [Dog]) -> [DogViewData] {
        dogs.map { DogViewData(breed: $0.breed,
                               description: "\($0.shortDescription) \($0.sizeInfo)") }
    }
}

