//
//  MovieView.swift
//  Movies Challenge
//
//  Created by Rajmund Zawiślak on 01/05/2023.
//

import SwiftUI
import TMDb
import Kingfisher

struct MovieView: View {
    
    let movie: Movie
    let size: CGSize

    private let downsamplingWidth = 480.0
    private let basePath = URL(string: "https://image.tmdb.org/t/p/original/")!
    
    var body: some View {
        ZStack(alignment: .bottom) {
            image
            infoView
        }
        .background(Color.white.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .frame(width: size.width, height: size.height)
    }
    
    @ViewBuilder
    private var image: some View {
        if let backdropPath = movie.backdropPath {
            
            KFImage(basePath.appending(path: backdropPath.path))
                .placeholder { _ in
                    ProgressView()
                        .progressViewStyle(.circular)
                }
                .downsampling(size: .init(width: downsamplingWidth, height: downsamplingWidth * 9 / 16))
                .resizable()
                
                .scaledToFill()
                .frame(width: size.width, height: size.height)
                .clipped()
        } else {
            Rectangle()
                .fill(Color.white.opacity(0.01))
        }
    }
    
    private var infoView: some View {
        VStack {
            Text(movie.title)
                .lineLimit(nil)
                .font(.caption)
            
            if let averageRating = movie.voteAverage {
                StarRatingView(rating: averageRating)
            }
        }
        .padding(4)
        .frame(maxWidth: .infinity)
        .background(Material.ultraThinMaterial)
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(movie: .sample, size: CGSize(width: 480, height: 270))
    }
}
