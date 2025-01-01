//
//  WelcomeView.swift
//  Tourify
//
//  Created by Kaozhi Chen on 1/1/25.
//

import SwiftUI

struct WelcomeView: View {
    @State private var isActive = false

    var body: some View {
        if isActive {
            LoginView()
        } else {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [
                    Color("PrimaryBlue"),
                    Color("PrimaryGreen")
                ]),
                startPoint: .top,
                endPoint: .bottom)
                .ignoresSafeArea()

                VStack() {
                    // Logo
                    Image("Tourify")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width * 0.7)

                    // loading
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .orange))
                        .scaleEffect(1.5)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    WelcomeView()
}
