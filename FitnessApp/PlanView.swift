//
//  PlanView.swift
//  FitnessApp
//
//  Created by Elin.Andersson on 2024-05-21.
//


import Foundation
import SwiftUI

struct PlanView: View {
    @Binding var isLoggedIn: Bool // Binding for log out
    @EnvironmentObject var userData: UserData // UserData environment object must be provided to all necessary views.

        init(isLoggedIn: Binding<Bool>) { // Ensure initializer accepts the binding
            self._isLoggedIn = isLoggedIn
            // Set the background color of the tab bar to white
            UITabBar.appearance().backgroundColor = UIColor.white
        }

    
    
   // init() {
        // Set the background color of the tab bar to white
     //   UITabBar.appearance().backgroundColor = UIColor.white
  //  }

    var body: some View {
        // TabView to create a tab bar interface
        TabView {
            // First tab: CalendarPage
            CalendarPage()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Plan")
                }
        
            WorkoutsView(selectedDay: .constant(""))
                .tabItem {
                    Image(systemName: "dumbbell")
                    Text("Workout")
                }
              RecepiesView(selectedDay: .constant(""))
              .tabItem {
                         Image(systemName: "fork.knife")
                         Text("Food")
                        }
           
            ProfileView(isLoggedIn: $isLoggedIn) //binding for log out
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
        // Set the accent color for the tab bar items
        .accentColor(Color(red: 27/255, green: 178/255, blue: 115/255))
    }
}

struct PlanView_Previews: PreviewProvider {
    @State static var isLoggedIn = true

    static var previews: some View {
        // Provide WorkoutData environment object for preview
        PlanView(isLoggedIn: $isLoggedIn)
            .environmentObject(WorkoutData())
            .environmentObject(UserData())
    }
}
