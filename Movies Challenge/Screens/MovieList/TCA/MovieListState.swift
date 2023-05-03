//
//  MovieListState.swift
//  Movies Challenge
//
//  Created by Rajmund Zawiślak on 01/05/2023.
//

import TMDb
import ComposableArchitecture

extension MovieListReducer {
    struct State: Equatable {
        var popularMovies: [Movie] = []
        var topRatedMovies: [Movie] = []
            
        var lastPopularMoviesResponse: MoviePageableList?
        var lastTopRatedMoviesResponse: MoviePageableList?
        var isInitialDataLoaded = false
        
        @BindingState var focusField: MovieListFocusField?
    }
}
