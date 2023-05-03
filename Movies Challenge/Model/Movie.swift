//
//  Movie.swift
//  Movies Challenge
//
//  Created by Rajmund Zawiślak on 01/05/2023.
//

import TMDb

extension TMDb.Movie {
    static var sample: Self {
        Self(
            id: .random(in: 1...100),
            title: "Ant-Man and the Wasp: Quantumania",
            tagline: "Witness the beginning of a new dynasty.",
            originalTitle: "Ant-Man and the Wasp: Quantumania",
            originalLanguage: "en",
            overview: "Super-Hero partners Scott Lang and Hope van Dyne, along with with Hope's parents Janet van Dyne and Hank Pym, and Scott's daughter Cassie Lang, find themselves exploring the Quantum Realm, interacting with strange new creatures and embarking on an adventure that will push them beyond the limits of what they thought possible.",
            runtime: .random(in: 75...180),
            genres: [.init(id: 28, name: "Action"), .init(id: 12, name: "Adventure"), .init(id: 878, name: "Science Fiction")],
            releaseDate: .now.addingTimeInterval(199999),
            posterPath: .init(string: "/ngl2FKBlU4fhbdsrtdom9LVLBXw.jpg"),
            backdropPath: .init(string: "/3CxUndGhUcZdt1Zggjdb2HkLLQX.jpg"),
            budget: .random(in: 100000000...300000000),
            revenue: 473237851,
            homepageURL: .init(string: "https://www.marvel.com/movies/ant-man-and-the-wasp-quantumania"),
            imdbID: "tt10954600",
            status: [Status.cancelled, Status.released, Status.postProduction].randomElement(),
            productionCompanies: [.init(id: 420, name: "Marvel Studios", originCountry: "US", logoPath: .init(string: "/hUzeosd33nzE5MCNsZxCGEKTXaQ.png"))],
            productionCountries: [.init(countryCode: "US", name: "United States of America")],
            spokenLanguages: [.init(languageCode: "PL", name: "Polish")],
            popularity: .random(in: 1...100000),
            voteAverage: .random(in: 1..<10),
            voteCount: .random(in: 1..<10000),
            video: .random(),
            adult: .random()
        )
    }
}
