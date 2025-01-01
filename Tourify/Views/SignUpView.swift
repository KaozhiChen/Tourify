//
//  SignUpView.swift
//  Tourify
//
//  Created by Kaozhi Chen on 1/1/25.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    @Environment(\.dismiss) var dismiss

    @State private var email = ""
    @State private var password = ""
    @State private var displayName = ""
    @State private var gender = "Male"
    @State private var age = ""
    @State private var selectedTags: [String] = []
    @State private var errorMessage: String?

    let travelTags = ["Beach", "Mountains", "City", "History", "Food", "Adventure"]

    var body: some View {
        ZStack {
            // background
            Color("NeutralWhite")
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Sign Up")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color("PrimaryBlue"))

                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 10)
                }

                VStack(spacing: 16) {
                    // Email
                    inputField(icon: "envelope", placeholder: "Email", text: $email, isSecure: false, keyboardType: .emailAddress)

                    // Password
                    inputField(icon: "lock", placeholder: "Password", text: $password, isSecure: true)

                    // Display Name
                    inputField(icon: "person", placeholder: "Display Name", text: $displayName, isSecure: false)

                    // Age
                    inputField(icon: "calendar", placeholder: "Age", text: $age, isSecure: false, keyboardType: .numberPad)

                    // Gender
                    Picker("Gender", selection: $gender) {
                        Text("Male").tag("Male")
                        Text("Female").tag("Female")
                        Text("Other").tag("Other")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                // Travel Interests
                VStack(alignment: .leading, spacing: 10) {
                    Text("Select Travel Interests")
                        .font(.headline)
                        .foregroundColor(Color("PrimaryBlue"))

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(travelTags, id: \.self) { tag in
                                Button(action: {
                                    if selectedTags.contains(tag) {
                                        selectedTags.removeAll { $0 == tag }
                                    } else {
                                        selectedTags.append(tag)
                                    }
                                }) {
                                    Text(tag)
                                        .padding()
                                        .background(selectedTags.contains(tag) ? Color("PrimaryBlue") : Color.gray.opacity(0.1))
                                        .foregroundColor(selectedTags.contains(tag) ? .white : .black)
                                        .cornerRadius(30)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.top, 10)

                // Sign Up Button
                Button(action: {
                    signUp()
                }) {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("AccentOrange"))
                        .cornerRadius(30)
                }

                // Cancel Button
                Button("Cancel") {
                    dismiss()
                }
                .foregroundColor(.red)
            }
            .padding(.horizontal)
            .frame(maxWidth: 350)
        }
        .onAppear {
            disableTextFieldToolbar()
        }
    }

    func inputField(icon: String, placeholder: String, text: Binding<String>, isSecure: Bool = false, keyboardType: UIKeyboardType = .default) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.gray)
            if isSecure {
                SecureField(placeholder, text: text)
            } else {
                TextField(placeholder, text: text)
                    .keyboardType(keyboardType)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(30)
    }

    func disableTextFieldToolbar() {
        UITextField.appearance().inputAssistantItem.leadingBarButtonGroups = []
        UITextField.appearance().inputAssistantItem.trailingBarButtonGroups = []
    }

    // login
    func signUp() {
        guard let userAge = Int(age), userAge >= 13 else {
            errorMessage = "Age must be 13 or older."
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                errorMessage = error.localizedDescription
                return
            }

            guard let userId = authResult?.user.uid else {
                errorMessage = "User ID is missing."
                return
            }

            // create user model
            let user = User(id: userId, displayName: displayName, email: email, gender: gender, age: userAge, travelTags: selectedTags)

            // save to Firestore
            let userManager = UserManager()
            userManager.saveUserData(user: user) { error in
                if let error = error {
                    errorMessage = error.localizedDescription
                } else {
                    print("User data saved successfully.")
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    SignUpView()
}
