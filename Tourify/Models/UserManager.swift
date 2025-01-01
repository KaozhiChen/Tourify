//
//  UserManager.swift
//  Tourify
//
//  Created by Kaozhi Chen on 1/1/25.
//

import FirebaseFirestore
import FirebaseAuth

class UserManager {
    private let db = Firestore.firestore()

    // save data to Firestore
    func saveUserData(user: User, completion: @escaping (Error?) -> Void) {
        db.collection("users").document(user.id).setData([
            "displayName": user.displayName,
            "email": user.email,
            "gender": user.gender,
            "age": user.age,
            "travelTags": user.travelTags
        ]) { error in
            completion(error)
        }
    }

    // get user data from Firestore
    func fetchUserData(userId: String, completion: @escaping (Result<User, Error>) -> Void) {
        db.collection("users").document(userId).getDocument { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = snapshot?.data(),
                  let displayName = data["displayName"] as? String,
                  let email = data["email"] as? String,
                  let gender = data["gender"] as? String,
                  let age = data["age"] as? Int,
                  let travelTags = data["travelTags"] as? [String] else {
                completion(.failure(NSError(domain: "UserManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid data"])))
                return
            }

            let user = User(id: userId, displayName: displayName, email: email, gender: gender, age: age, travelTags: travelTags)
            completion(.success(user))
        }
    }
}
