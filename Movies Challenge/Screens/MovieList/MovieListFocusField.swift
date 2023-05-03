//
//  MovieListFocusField.swift
//  Movies Challenge
//
//  Created by Rajmund Zawiślak on 01/05/2023.
//

import TMDb

enum MovieListFocusField: Hashable, Equatable {
    case popular(movie: Movie)
    case topRated(movie: Movie)
}
