//
//  User.swift
//  Tourify
//
//  Created by Kaozhi Chen on 1/1/25.
//

import Foundation

struct User: Codable {
    var id: String
    var displayName: String
    var email: String
    var gender: String
    var age: Int
    var travelTags: [String]

    // init
    init(id: String, displayName: String, email: String, gender: String, age: Int, travelTags: [String]) {
        self.id = id
        self.displayName = displayName
        self.email = email
        self.gender = gender
        self.age = age
        self.travelTags = travelTags
    }
}
