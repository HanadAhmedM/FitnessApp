//
//  User.swift
//  FitnessApp
//
//  Created by Hanad.Ahmed on 2024-05-07.
//

import Foundation
class User {
    let id: String
    let userName: String
    let email: String
    
    init(id: String, userName: String, email: String) {
        self.id = id
        self.userName = userName
        self.email = email
    }
    
    func description() -> String {
        return "User(id = \(id), userName = \(userName), email = \(email))"
    }
}
