//
//  LoginView.swift
//  Tourify
//
//  Created by Kaozhi Chen on 1/1/25.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoggingIn = false
    @State private var showSignUpSheet = false
    @State private var errorMessage: String? = nil
    @State private var isLoggedIn = false

    var body: some View {
        if isLoggedIn {
            MainTabView()
        } else {
            ZStack {
                // background
                LinearGradient(gradient: Gradient(colors: [
                    Color("PrimaryBlue"),
                    Color("PrimaryGreen")
                ]),
                startPoint: .top,
                endPoint: .bottom)
                .ignoresSafeArea()

                VStack(spacing: 16) {
                    // Logo
                    Image("Tourify")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .padding(.bottom, 20)

                    // Email
                    HStack {
                        Image(systemName: "envelope")
                            .foregroundColor(.gray)
                        TextField("Email", text: $email)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                            .disableAutocorrection(true)
                    }
                    .padding()
                    .background(Color.white.opacity(0.85))
                    .cornerRadius(30)
                    .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.gray.opacity(0.5)))

                    // Password
                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(.gray)
                        SecureField("Password", text: $password)
                    }
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(30)
                    .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.gray.opacity(0.5)))

                    // Error Message
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 10)
                    }

                    // Login
                    Button(action: {
                        login()
                    }) {
                        if isLoggingIn {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                        } else {
                            Text("Login")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [
                                        Color("AccentOrange"),
                                        Color("AccentYellow")
                                    ]),
                                    startPoint: .leading,
                                    endPoint: .trailing)
                                )
                                .cornerRadius(30)
                                .shadow(color: Color("AccentOrange").opacity(0.5), radius: 30, x: 0, y: 5)
                        }
                    }
                    .disabled(isLoggingIn)

                    HStack {
                        Text("Don't have an account?")
                            .foregroundColor(.white.opacity(0.8))

                        Button(action: {
                            // sign up
                            showSignUpSheet = true
                        }) {
                            Text("Sign Up")
                                .fontWeight(.bold)
                                .foregroundColor(Color("AccentOrange"))
                        }
                    }

                    Button(action: {
                        // forgot password
                    }) {
                        Text("Forgot Password?")
                            .foregroundColor(.white.opacity(0.8))
                            .underline()
                    }
                    .padding(.top, 10)
                }
                .padding()
                .frame(maxWidth: 350)
                .sheet(isPresented: $showSignUpSheet) {
                    SignUpView()
                        .presentationDetents([.fraction(0.8)])
                        .presentationCornerRadius(40)
                        .presentationDragIndicator(.visible)
                }
            }
        }
    }

    // login logic
    func login() {
        isLoggingIn = true
        errorMessage = nil

        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            isLoggingIn = false
            if let error = error {
                errorMessage = error.localizedDescription
                return
            }

            // login successfully
            withAnimation {
                isLoggedIn = true
            }
        }
    }
}

#Preview {
    LoginView()
}
