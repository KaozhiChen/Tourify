//
//  HomeViewModel.swift
//  Tourify
//
//  Created by Kaozhi Chen on 1/2/25.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    // data resource
    @Published var popularPlaces: [Place] = []
    @Published var recommendedPlaces: [Place] = []
    @Published var isLoading: Bool = true
    @Published var errorMessage: String? = nil

    // fetch data
    init() {
        fetchData()
    }

    // function to fetch data
    func fetchData() {
        isLoading = true
        errorMessage = nil

        DispatchQueue.global().asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self = self else { return }

            // data
            let popular = [
                Place(name: "Mount Everest", location: "Sagarmatha, Nepal", rating: 4.9, imageUrl: "placeholder"),
                Place(name: "Pashupatinath Temple", location: "Kathmandu, Nepal", rating: 4.8, imageUrl: "placeholder")
            ]
            let recommended = [
                Place(name: "Lubini Temple", location: "Lumbini, Nepal", rating: 4.7, imageUrl: "placeholder"),
                Place(name: "Mustang", location: "Mustang, Nepal", rating: 4.6, imageUrl: "placeholder")
            ]

            // loading data successfully
            DispatchQueue.main.async {
                self.popularPlaces = popular
                self.recommendedPlaces = recommended
                self.isLoading = false
            }
        }
    }
}
