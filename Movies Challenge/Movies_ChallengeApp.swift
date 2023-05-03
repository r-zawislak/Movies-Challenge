//
//  Movies_ChallengeApp.swift
//  Movies Challenge
//
//  Created by Rajmund Zawiślak on 01/05/2023.
//

import SwiftUI

@main
struct Movies_ChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            MovieListView(
                store: .init(
                    initialState: .init(),
                    reducer: MovieListReducer()
                )
            )
        }
    }
}
