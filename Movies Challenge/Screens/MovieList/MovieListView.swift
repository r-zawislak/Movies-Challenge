//
//  MovieListView.swift
//  Movies Challenge
//
//  Created by Rajmund Zawiślak on 01/05/2023.
//

import SwiftUI
import Kingfisher
import TMDb
import ComposableArchitecture

struct MovieListView: View {
    private let store: StoreOf<MovieListReducer>
    private let screenSize = UIScreen.main.bounds
    
    @ObservedObject private var viewStore: ViewStore<MovieListReducer.State, MovieListReducer.Action>
    
    @FocusState private var focusField: MovieListFocusField?
    
    init(store: StoreOf<MovieListReducer>) {
        self.store = store
        viewStore = ViewStore(store)
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                list(
                    for: viewStore.popularMovies,
                    title: "Popular",
                    fetchMoreAction: .fetchMorePopularMovies,
                    createFocusField: MovieListFocusField.popular,
                    itemSize: CGSize(width: 960, height: 540)
                )
                list(
                    for: viewStore.topRatedMovies,
                    title: "Top Rated",
                    fetchMoreAction: .fetchMoreTopRatedMovies,
                    createFocusField: MovieListFocusField.topRated,
                    itemSize: CGSize(width: 480, height: 350)
                )
            }
            .padding()
        }
        .onAppear {
            viewStore.send(.fetchData)
        }
        .synchronize(viewStore.binding(\.$focusField), $focusField)
    }
    
    @ViewBuilder
    private func list(
        for movies: [Movie],
        title: String,
        fetchMoreAction: MovieListReducer.Action,
        createFocusField: @escaping (Movie) -> MovieListFocusField,
        itemSize: CGSize
    ) -> some View {
        if movies.isEmpty {
            EmptyView()
        }
        
        VStack {
            Text(title)
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            ScrollViewReader { proxy in
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(movies) { movie in
                            movieView(for: movie, field: createFocusField(movie), size: itemSize)
                        }
                        
                        ProgressView()
                            .progressViewStyle(.circular)
                            .onAppear {
                                viewStore.send(fetchMoreAction)
                            }
                    }
                }
                .onChange(of: focusField) { newValue in
                    guard let newValue else {
                        return
                    }

                    withAnimation {
                        proxy.scrollTo(newValue, anchor: .center)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func movieView(for movie: Movie, field: MovieListFocusField, size: CGSize) -> some View {
        let isSelected = focusField == field
        
        MovieView(movie: movie, size: size)
            .id(field)
            .focusable()
            .focused($focusField, equals: field)
            .scaleEffect(isSelected ? 1 : 0.85)
            .animation(.linear, value: focusField)
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(
            store: .init(
                initialState: .init(),
                reducer: MovieListReducer()
            )
        )
    }
}
