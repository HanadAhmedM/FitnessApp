//
//  RegisterView.swift
//  FitnessApp
//
//  Created by Elin.Andersson on 2024-05-05.
//
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct RegisterView: View {
   // @State private var id = ""
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button("Register") {
                registerUser()
            }
        }
        .padding()
    }
    
    func registerUser() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error registering user: \(error.localizedDescription)")
            } else if let user = authResult?.user {
                print("User registered: \(user.uid)")
                // Add user to Firestore
                addUserToFirestore(user: user)
            }
        }
    }
    
    func addUserToFirestore(user: User) {
        let db = Firestore.firestore()
        db.collection("users").document(user.uid).setData([
            "email": user.email ?? "No Email",
            "uid": user.uid
        ]) { error in
            if let error = error {
                print("Error adding user to Firestore: \(error.localizedDescription)")
            } else {
                print("User added to Firestore with UID: \(user.uid)")
            }
        }
    }
}
