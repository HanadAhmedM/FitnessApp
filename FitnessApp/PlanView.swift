//
//  PlanView.swift
//  FitnessApp
//
//  Created by Elin.Andersson on 2024-05-21.
//


import Foundation
import SwiftUI

struct PlanView: View {
    @EnvironmentObject var workoutData: WorkoutData

    init() {
        // Set the background color of the tab bar to white
        UITabBar.appearance().backgroundColor = UIColor.white
    }

    var body: some View {
        // TabView to create a tab bar interface
        TabView {
            // First tab: CalendarPage
            CalendarPage()
                .tabItem {
                    Image(systemName: "calendar") // Icon for the tab
                    Text("Plan") // Text label for the tab
                }
            // Second tab: WorkoutsView with a default selected day
            WorkoutsView(selectedDay: .constant("M")) // Temporary default value for selected day
                .tabItem {
                    Image(systemName: "dumbbell") // Icon for the tab
                    Text("Workout") // Text label for the tab
                }
            RecepiesView(selectedDay: .constant("M")) // Temporary default value for selected day
                    .tabItem {
                    Image(systemName: "fork.knife") // Icon for the tab (use appropriate system image)
                    Text("Food") // Text label for the tab
                 }
            // Fourth tab: ProfileView
            ProfileView()
                .tabItem {
                    Image(systemName: "person") // Icon for the tab
                    Text("Profile") // Text label for the tab
                }
        }
        // Set the accent color for the tab bar items
        .accentColor(Color(red: 27/255, green: 178/255, blue: 115/255))
    }
}

struct PlanView_Previews: PreviewProvider {
    static var previews: some View {
        // Provide WorkoutData environment object for preview
        PlanView().environmentObject(WorkoutData())
    }
}
