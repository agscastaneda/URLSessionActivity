//
//  CatsUIComposer.swift
//  URLSessionSample
//
//  Created by Victor Pacheco on 16/02/23.
//

import UIKit

final class CatsUIComposer {
    
    static func compose() -> MenuTabController {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decoderResultsAdapter = JSONDecoderResultAdapter(decoder: decoder)
        let catsFetcher = URLSessionFetcher(urlRequestFactory: CatsEndpoint(), decodableResultAdapter: decoderResultsAdapter)
        let mainFetcherDecorator = MainThreadFetcherDecorator(fetcher: catsFetcher)
        let favoriteCatsSaver = UserDefaultsSaver()
        let catsService = CatsServiceImp(fetcher: mainFetcherDecorator, saver: favoriteCatsSaver)
        let catsViewController = CatsViewController(catsService: catsService)
        return catsViewController
    }
}
