//
//  Place.swift
//  Tourify
//
//  Created by Kaozhi Chen on 1/2/25.
//

import Foundation

// place model
struct Place: Identifiable {
    let id = UUID()
    let name: String
    let location: String
    let rating: Double
    let imageUrl: String

    let price: String? = nil
    let description: String? = nil
}
