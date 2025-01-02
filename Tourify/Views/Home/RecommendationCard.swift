//
//  RecommendationCard.swift
//  Tourify
//
//  Created by Kaozhi Chen on 1/2/25.
//

import SwiftUI

struct RecommendationCard: View {
    let placeName: String
    let location: String
    let price: String
    let imageName: String

    var body: some View {
        HStack(spacing: 10) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 8) {
                Text(placeName)
                    .font(.headline)
                Text(location)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(price)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
            }

            Spacer()
        }
        .padding(8)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius:5, x:0, y:3)
    }
}
