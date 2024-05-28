//
//  UserData.swift
//  FitnessApp
//
//  Created by Elin.Andersson on 2024-05-28.
//an observable object to store the logged-in user's info

import Foundation
import Firebase
class UserData: ObservableObject {
    @Published var user: User?

    func fetchUser(userId: String) {
        FireBase().fetchUser(userId: userId) { [weak self] user in
            self?.user = user
        }
    }
}
