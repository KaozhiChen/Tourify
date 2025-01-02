//
//  HomeView.swift
//  Tourify
//
//  Created by Kaozhi Chen on 1/1/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    topBar
                    popularPlacesSection
                    recommendationSection
                }
                .padding(.horizontal)
            }
        }
    }

    // top bar
    private var topBar: some View {
        HStack {
            Button(action: {
            }) {
                HStack {
                    Text("Your Location")
                        .font(.headline)
                        .foregroundColor(.black)
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                }
            }

            Spacer()

            // user
            Button(action: {
                // go to profile
            }) {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.gray)
            }
        }
        .padding(.top, 10)
    }

    // pop section
    private var popularPlacesSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Popular Places")
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                Button(action: {
                    // go to more
                }) {
                    Text("See All")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(0..<5) { index in
                        PopularPlaceCard(
                            placeName: "Place \(index + 1)",
                            location: "Location \(index + 1)",
                            imageName: "placeholder",
                            rating: Double.random(in: 4.0...5.0)
                        )
                    }
                }
            }
        }
    }

    // recommend section
    private var recommendationSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Recommended for You")
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                Button(action: {
                    // go to more
                }) {
                    Text("See All")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
            }

            VStack(spacing: 15) {
                ForEach(0..<5) { index in
                    RecommendationCard(
                        placeName: "Recommended \(index + 1)",
                        location: "Location \(index + 1)",
                        price: "$\(index * 100 + 199) / Person",
                        imageName: "placeholder"
                    )
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
