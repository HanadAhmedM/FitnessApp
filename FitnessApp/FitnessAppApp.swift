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
@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate // register app delegate for Firebase setup
    @StateObject private var workoutData = WorkoutData()
    @StateObject private var userData = UserData()
    @State private var isLoggedIn = false
    
    var body: some Scene {
        WindowGroup {
           ContentView(isLoggedIn: $isLoggedIn)
                .environmentObject(WorkoutData())
                .environmentObject(userData)
        }
    }
}
