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
    func loginUser(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error as NSError? {
                // Handle specific error cases
                if let errorCode = AuthErrorCode.Code(rawValue: error.code) {
                    switch errorCode {
                    case .userNotFound:
                        print("User not found.")
                    case .wrongPassword:
                        print("Incorrect password.")
                    case .invalidEmail:
                        print("Invalid email address.")
                    default:
                        print("Login failed: \(error.localizedDescription)")
                    }
                } else {
                    print("Login failed: \(error.localizedDescription)")
                }
                completion(false, error)
            } else {
                print("Login successful")
                completion(true, nil)
            }
        }
    }

       func logoutUser(completion: @escaping (Bool) -> Void) {
           do {
               try Auth.auth().signOut()
               print("User successfully logged out")
               completion(true)
           } catch let error as NSError {
               print("Error signing out: \(error.localizedDescription)")
               completion(false)
           }
       }

       func register(username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
                     
           Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
               guard let self = self else { return }
               if let error = error {
                   print(error.localizedDescription)
                   completion(false)
               } else {
                   guard let firebaseUser = result?.user else {
                       print("Error creating user.")
                       completion(false)
                       return
                   }
                   
                   let changeRequest = firebaseUser.createProfileChangeRequest()
                   changeRequest.displayName = username
                   changeRequest.commitChanges { error in
                       if let error = error {
                           print("Error updating user profile: \(error.localizedDescription)")
                           completion(false)
                       } else {
                           print("User profile updated successfully!")
                           
                           let newUser = self.createUser(userId: firebaseUser.uid, username: username, email: email)
                           self.userDao.addUser(user: newUser)
                           completion(true)
                       }
                   }
               }
           }
       }

      
       
       func createUser(userId: String, username: String, email: String) -> User {
           return User(id: userId, userName: username, email: email)
       }
       
       private func hashPassword(_ password: String) -> String? {
           guard let data = password.data(using: .utf8) else { return nil }
           let hashed = SHA256.hash(data: data)
           return hashed.compactMap { String(format: "%02x", $0) }.joined()
       }
   }


