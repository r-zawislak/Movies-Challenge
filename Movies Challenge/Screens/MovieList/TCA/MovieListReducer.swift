//
//  MovieListReducer.swift
//  Movies Challenge
//
//  Created by Rajmund Zawiślak on 01/05/2023.
//

import ComposableArchitecture
import TMDb

struct MovieListReducer: ReducerProtocol {
    
    @Dependency(\.movieService) private var movieService
    
    var body: some ReducerProtocol<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .fetchData:
                let effects = [
                    Action.fetchMorePopularMovies,
                    Action.fetchMoreTopRatedMovies
                ]
                .map {
                    EffectTask(value: $0)
                }
                
                return .merge(effects)
            case .fetchMorePopularMovies:
                return fetchMoreMovies(
                    lastResponse: &state.lastPopularMoviesResponse,
                    fetchMovies: movieService.popular,
                    action: Action.popularMoviesResponse
                )
            case .fetchMoreTopRatedMovies:
                return fetchMoreMovies(
                    lastResponse: &state.lastTopRatedMoviesResponse,
                    fetchMovies: movieService.topRated,
                    action: Action.topRatedMoviesResponse
                )
            case .topRatedMoviesResponse(.success(let response)):
                updateMoviesState(currentMovies: &state.topRatedMovies, lastResponse: &state.lastTopRatedMoviesResponse, response: response)
            case .popularMoviesResponse(.success(let response)):
                updateMoviesState(currentMovies: &state.popularMovies, lastResponse: &state.lastPopularMoviesResponse, response: response)
                
                guard let firstMovie = state.popularMovies.first, !state.isInitialDataLoaded else {
                    return .none
                }
                
                state.focusField = .popular(movie: firstMovie)
                state.isInitialDataLoaded = true
            default:
                break
            }
            
            return .none
        }
    }
    
    private func fetchMoreMovies(
        lastResponse: inout MoviePageableList?,
        fetchMovies: @escaping (Int) async throws -> MoviePageableList,
        action: @escaping (TaskResult<MoviePageableList>) -> Action
    ) -> EffectTask<Action> {
        let fetchPage = (lastResponse?.page ?? 0) + 1

        guard fetchPage < lastResponse?.totalPages ?? .max else {
            return .none
        }

        return .task {
            await action(
                TaskResult {
                    try await fetchMovies(fetchPage)
                }
            )
            
        }
    }
    
    private func updateMoviesState(currentMovies: inout [Movie], lastResponse: inout MoviePageableList?, response: MoviePageableList) {
        var filteredResults = response.results
        filteredResults.removeAll(where: currentMovies.contains)

        currentMovies.append(contentsOf: filteredResults)
        lastResponse = response
    }
}
