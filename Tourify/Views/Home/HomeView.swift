//
//  HomeView.swift
//  Tourify
//
//  Created by Kaozhi Chen on 1/1/25.
//

import SwiftUI

struct HomeView: View {
    // init HomeViewModel
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            if viewModel.isLoading {
                ProgressView("Loading...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    VStack(spacing: 20) {
                        topBar
                        popularPlacesSection
                        recommendationSection
                    }
                    .padding(.horizontal)
                }
                .navigationTitle("Home") 
                .navigationBarHidden(true)
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

            // user profile
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

    // popular places section
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
                        .foregroundColor(Color("PrimaryBlue"))
                }
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(viewModel.popularPlaces) { place in
                        PopularPlaceCard(
                            placeName: place.name,
                            location: place.location,
                            imageName: place.imageUrl,
                            rating: place.rating
                        )
                    }
                }
            }
        }
    }

    // recommendation section
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
                        .foregroundColor(Color("PrimaryBlue"))
                }
            }

            VStack(spacing: 15) {
                ForEach(viewModel.recommendedPlaces) { place in
                    RecommendationCard(
                        placeName: place.name,
                        location: place.location,
                        price: place.price ?? "$199 / Person",
                        imageName: place.imageUrl
                    )
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
