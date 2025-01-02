//
//  PopularPlaceCard.swift
//  Tourify
//
//  Created by Kaozhi Chen on 1/2/25.
//

import SwiftUI

struct PopularPlaceCard: View {
    let placeName: String
    let location: String
    let imageName: String
    let rating: Double

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // image
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 300, height: 200)
                .cornerRadius(15)
                .clipped()

            // content
            ZStack {
                Rectangle()
                    .fill(Color.black.opacity(0.6))
                    .frame(height: 60)
                    .cornerRadius(15, corners: [.bottomLeft, .bottomRight])

                // descrition and rating
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(placeName)
                            .font(.headline)
                            .foregroundColor(.white)
                        HStack {
                            Image(systemName: "location.fill")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .foregroundColor(.white.opacity(0.8))
                            Text(location)
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.8))
                        }
                    }
                    Spacer()

                    // rating
                    HStack(spacing: 6) {
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .alignmentGuide(.firstTextBaseline) { d in d[.bottom] }
                            .foregroundColor(Color("AccentOrange"))
    
                        Text(String(format: "%.1f", rating))
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .alignmentGuide(.firstTextBaseline) { d in d[.bottom] }
                    }
                }
                .padding(.horizontal, 10)
            }
        }
        .frame(width: 300, height: 200)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = 0
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

