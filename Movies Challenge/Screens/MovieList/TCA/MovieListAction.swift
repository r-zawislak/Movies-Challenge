//
//  MovieListAction.swift
//  Movies Challenge
//
//  Created by Rajmund Zawiślak on 01/05/2023.
//

import Foundation
import TMDb
import ComposableArchitecture

extension MovieListReducer {
    enum Action: Equatable, BindableAction {
        case fetchData
        case popularMoviesResponse(response: TaskResult<MoviePageableList>)
        case topRatedMoviesResponse(response: TaskResult<MoviePageableList>)
        case binding(BindingAction<State>)
        case fetchMorePopularMovies
        case fetchMoreTopRatedMovies
    }
}
