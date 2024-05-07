//
//  ProfilePage.swift
//  FitnessApp
//
//  Created by Elin.Andersson on 2024-05-08.
//

import Foundation

import Foundation
import SwiftUI
struct ProfilePage: View {
    @State private var selectedDay: String = ""
    @State private var showingAddWorkout = false
    
    let weekDays = ["M", "T", "W", "T", "F", "S", "S"]
    let exercises = ["Jumping Jacks", "High Knee", "Squats"]
    
    var body: some View {
        NavigationView {
            ZStack{
                
                VStack {
                    HStack {
                        ForEach(weekDays, id: \.self) { day in
                            Text(day)
                                .frame(width: 30, height: 30)
                                .background(selectedDay == day ? Color.green : Color.clear)
                                .cornerRadius(15)
                                .onTapGesture {
                                    self.selectedDay = day
                                    self.showingAddWorkout = true
                                }
                        }
                    }
                    .padding(.top, 20)
                    .cornerRadius(15)
                    List {
                        ForEach(exercises, id: \.self) { exercise in
                            HStack {
                                Image(exercise) // Assumes you have these images in your assets
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                Text(exercise)
                            }
                        }
                    }
                    .sheet(isPresented: $showingAddWorkout) {
                        AddWorkoutView(selectedDay: $selectedDay)
                    }
                }
                .navigationBarTitle("Plan", displayMode: .inline)
                .padding()
            }
            .background(Color(red: 27/255, green: 178/255, blue: 115/255).edgesIgnoringSafeArea(.all)) // Apply background color here
        }
    }
}
struct AddWorkoutView: View {
    @Binding var selectedDay: String
    @State private var selectedExercise: String = ""
    let exercises = ["Jumping Jacks", "High Knee", "Squats"]
    var body: some View {
        VStack {
            Text("Add a workout for \(selectedDay)")
            Picker("Select Exercise", selection: $selectedExercise) {
                ForEach(exercises, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(WheelPickerStyle())
            
            Button("Add Exercise") {
                // Logic to add exercise to the day
                print("Added \(selectedExercise) to \(selectedDay)")
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}
struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
