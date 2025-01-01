//
//  TourifyApp.swift
//  Tourify
//
//  Created by Kaozhi Chen on 1/1/25.
//

import SwiftUI
import FirebaseCore

@main
struct TourifyApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            WelcomeView()
        }
    }
}
