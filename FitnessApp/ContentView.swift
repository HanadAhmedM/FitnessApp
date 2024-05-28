//
//  ContentView.swift
//  FitnessApp
//
//  Created by Hanad.Ahmed on 2024-05-02.
//

import SwiftUI

struct ContentView: View {
   // @State private var isLoggedIn = false
    @Binding var isLoggedIn: Bool
    @EnvironmentObject var userData: UserData

    var body: some View {
            if isLoggedIn {
                PlanView(isLoggedIn: $isLoggedIn)
                    .environmentObject(userData)
            } else {
                LoginPage(isLoggedIn: $isLoggedIn)
            }
        }
    }

    struct ContentView_Previews: PreviewProvider {
        @State static var isLoggedIn = false

        static var previews: some View {
            ContentView(isLoggedIn: $isLoggedIn)
                .environmentObject(WorkoutData())
                .environmentObject(UserData())
        }
    }
