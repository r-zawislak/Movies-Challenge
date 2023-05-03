//
//  StarRatingView.swift
//  Movies Challenge
//
//  Created by Rajmund Zawiślak on 01/05/2023.
//

import SwiftUI
struct StarRatingView: View {
    let rating: Double
    
    var body: some View {
        HStack(spacing: 9) {
            ForEach(0..<5) { index in
                star(for: index)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 25)
                    .foregroundColor(.yellow)
            }
            Text("\(rating, specifier: "(%.1f)")")
                .font(.caption)
        }
    }
    
    private func star(for index: Int) -> Image {
        let starIndex = Double(index) * 2.0
        if rating >= starIndex + 1.5 {
            return Image(systemName: "star.fill")
        } else if rating >= starIndex + 0.5 {
            return Image(systemName:"star.lefthalf.fill")
        } else {
            return Image(systemName: "star")
        }
    }
}

struct StarRatingView_Previews: PreviewProvider {
    static var previews: some View {
        StarRatingView(rating: 7)
    }
}
