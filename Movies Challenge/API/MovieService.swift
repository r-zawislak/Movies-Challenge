//
//  MovieService.swift
//  Movies Challenge
//
//  Created by Rajmund Zawiślak on 01/05/2023.
//

import Foundation
import Dependencies
import TMDb

struct MovieService: DependencyKey {
    
    var popular: @Sendable (_ page: Int) async throws -> MoviePageableList
    var topRated: @Sendable (_ page: Int) async throws -> MoviePageableList
    
    private static let api = TMDbAPI(apiKey: "")
    
    static var liveValue: MovieService {
        Self(
            popular: { page in
               try await api.movies.popular(page: page)
            },
            topRated: { page in
                try await api.movies.topRated(page: page)
            }
        )
    }
    
    static var previewValue: MovieService {
        Self(
            popular: { _ in
                MoviePageableList(results: [.sample, .sample, .sample])
            },
            topRated: { _ in
                MoviePageableList(results: [.sample, .sample, .sample])
            }
        )
    }
}

extension DependencyValues {
    var movieService: MovieService {
        get { self[MovieService.self] }
        set { self[MovieService.self] = newValue }
    }
}
