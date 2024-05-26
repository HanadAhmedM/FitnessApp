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
    @EnvironmentObject var workoutData: WorkoutData

    
    var body: some Scene {
        WindowGroup {
            LoginPage()
                .environmentObject(WorkoutData())
        }
    }
}
