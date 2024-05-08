//
//  UserDao.swift
//  FitnessApp
//
//  Created by Hanad.Ahmed on 2024-05-07.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase

class UserDao: ObservableObject {
    @Published var users = [User]() // Declare users as an array of User objects
        
    let ID_KEY = "id"
    let USER_NAME_KEY = "userName" // Corrected constant name
    let EMAIL_KEY = "email"
    
    func addUser(user: User) {
        let dataToStore: [String: Any] = [
            ID_KEY: user.id,
            USER_NAME_KEY: user.userName,
            EMAIL_KEY: user.email
        ]

        let db = Firestore.firestore()
        db.collection("users").document(user.id).setData(dataToStore) { error in
            if let error = error {
                print("Error adding user: \(error)")
            } else {
                print("User added to Firestore with ID: \(user.id)")
            }
        }
    }
}   
