//
//  CatsServiceImp.swift
//  URLSessionSample
//
//  Created by Victor Pacheco on 14/02/23.
//

import Foundation

final class CatsServiceImp: CatsService {
    
    private let fetcher: Fetcher
    private let saver: Saver
    
    enum CatsErrors {
        case emptyListError
        case serverError
        case unknownError
    }
    
    init(fetcher: Fetcher, saver: Saver) {
        self.fetcher = fetcher
        self.saver = saver
    }
    
    func getCats(completion: @escaping (Result<[CatViewData], Error>) -> Void) {
        fetcher.fetchData() { [weak self] (result: Result<[Cat], Error>) in
            guard let self = self else { return completion(.failure(CatsErrors.unknownError)) }
            switch result {
            case let .success(cats):
                let cats = self.mapToViewData(cats)
                guard !cats.isEmpty else { return completion(.failure(CatsErrors.emptyListError)) }
                
                completion(.success(cats))
            case let .failure(error):
                completion(.failure(self.handle(error: error)))
            }
        }
    }
    
    func mapToViewData(_ cats: [Cat]) -> [CatViewData] {
        cats.map { cat in
            CatViewData(breed: cat.breed, size: cat.size.description, selection: { [weak self] in
                self?.saveFavorite(cat)
            })
        }
    }
    
    private func saveFavorite(_ cat: Cat) {
        saver.saveData(data: cat, key: "favorite-cats-\(cat.identifier)") { result in
            switch result {
            case let .success(cat):
                print("Saved cat with identifier:", cat.identifier)
            case let .failure(error):
                print("Oops! An \(error) occured while saving:", cat)
            }
        }
    }
    
    private func handle(error: Error) -> CatsErrors {
        guard let serverErrors = error as? NetworkingServerErrors else { return CatsErrors.unknownError }
        switch serverErrors {
        case .internalServerError:
            return CatsErrors.emptyListError
        case .dataNotFound:
            return CatsErrors.serverError
        case .unknownError:
            return CatsErrors.unknownError
        }
    }
}

extension CatsServiceImp.CatsErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .emptyListError:
            return "No encontramos gatitos en este momento."
        case .serverError:
            return "El servidor de gatitos está fuera de servicio. Inténtalo más tarde."
        case .unknownError:
            return "Ocurrió un error desconocido mientras buscábamos gatitos :("
        }
    }
}
