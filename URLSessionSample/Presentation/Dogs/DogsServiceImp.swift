//
//  DogsServiceImp.swift
//  URLSessionSample
//
//  Created by Victor Pacheco on 16/02/23.
//

import Foundation

final class DogsServiceImp: DogsService {
    
    private let fetcher: AsyncFetcher
    
    enum DogsErrors {
        case emptyListError
        case serverError
        case unknownError
    }
    
    init(fetcher: AsyncFetcher) {
        self.fetcher = fetcher
    }
    
    func getDogs() async throws -> [DogViewData] {
        do {
            let dogs: [Dog] = try await fetcher.fetchData()
            guard !dogs.isEmpty else { throw DogsErrors.emptyListError }
            let presentableDogs = mapToViewData(dogs)
            return presentableDogs
        } catch NetworkingServerErrors.dataNotFound {
            throw DogsErrors.emptyListError
        } catch NetworkingServerErrors.internalServerError {
            throw DogsErrors.serverError
        } catch {
            throw DogsErrors.unknownError
        }
    }
    
    func mapToViewData(_ dogs: [Dog]) -> [DogViewData] {
        dogs.map { DogViewData(breed: $0.breed,
                               description: "\($0.shortDescription) \($0.sizeInfo)") }
    }
}

extension DogsServiceImp.DogsErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .emptyListError:
            return "No encontramos perritos en este momento."
        case .serverError:
            return "El servidor de perritos está fuera de servicio. Inténtalo más tarde."
        case .unknownError:
            return "Ocurrió un error desconocido mientras buscábamos perritos :("
        }
    }
}
