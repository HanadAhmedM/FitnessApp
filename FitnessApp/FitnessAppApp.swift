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
    // register app delegate for Firebase setup
        @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var workoutData = WorkoutData()
    @State private var isLoggedIn = false
    
    var body: some Scene {
        WindowGroup {
           ContentView()
                .environmentObject(WorkoutData())
        }
    }
}
