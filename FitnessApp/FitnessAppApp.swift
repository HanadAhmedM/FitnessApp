//
//  FitnessAppApp.swift
//  FitnessApp
//
//  Created by Hanad.Ahmed on 2024-05-02.
//

import SwiftUI
import Firebase
@main
struct FitnessAppApp: App {
  
    init(){
     
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
          RegisterPage()
        }
    }
}
