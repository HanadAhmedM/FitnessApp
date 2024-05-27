//
//  ContentView.swift
//  FitnessApp
//
//  Created by Hanad.Ahmed on 2024-05-02.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn = false

       var body: some View {
           NavigationView {
               VStack {
                   if isLoggedIn {
                       PlanView()
                   } else {
                       LoginPage(isLoggedIn: $isLoggedIn)
                   }
               }
           }
       }
   }
#Preview {
    ContentView()
}
