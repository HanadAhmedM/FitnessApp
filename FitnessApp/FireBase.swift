//
//  FireBase.swift
//  FitnessApp
//
//  Created by Hanad.Ahmed on 2024-05-07.
//

import Foundation
import FirebaseFirestore
import Firebase
import CryptoKit

class FireBase {
    let userDao = UserDao()
      
    func register(username: String, email: String, password: String) {
        // Hash the password
        guard let hashedPassword = hashPassword(password) else {
            print("Error hashing password.")
            return
        }
        
        // Create the user with custom ID and email
        Auth.auth().createUser(withEmail: email, password: hashedPassword) { [weak self] result, error in
            guard let self = self else { return }
            if let error = error {
                print(error.localizedDescription)
            } else {
                // Get the user's reference
                guard let firebaseUser = result?.user else {
                    print("Error creating user.")
                    return
                }
                
                // Update the user's display name with the provided username
                let changeRequest = firebaseUser.createProfileChangeRequest()
                changeRequest.displayName = username
                changeRequest.commitChanges { error in
                    if let error = error {
                        print("Error updating user profile: \(error.localizedDescription)")
                    } else {
                        print("User profile updated successfully!")
                        
                        // Proceed with adding the user to Firestore
                        let newUser = self.createUser(userId: firebaseUser.uid, username: username, email: email)
                        self.addUserToFirestore(firebaseUser: firebaseUser, user: newUser)
                    }
                }
            }
        }
    }

    func addUserToFirestore(firebaseUser: FirebaseAuth.User, user: User) {
        // Now you can use firebaseUser to get information like uid, email, etc.
        // and pass the user object created from your app to UserDao for storing in Firestore

        self.userDao.addUser(user: user)
    }
    
    func createUser(userId: String, username: String, email: String) -> User {
        return User(id: userId, userName: username, email: email)
    }
    
    // Function to hash password using SHA-256
    private func hashPassword(_ password: String) -> String? {
        guard let data = password.data(using: .utf8) else { return nil }
        let hashed = SHA256.hash(data: data)
        return hashed.compactMap { String(format: "%02x", $0) }.joined()
    }
}
