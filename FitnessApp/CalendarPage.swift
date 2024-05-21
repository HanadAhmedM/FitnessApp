//
//  CalendarPage.swift
//  FitnessApp
//
//  Created by Elin.Andersson on 2024-05-21.
//Kalender

import SwiftUI
import Foundation

struct CalendarPage: View {
    @State private var selectedDay: String = "T" // State variable to track the selected day of the week
    @State private var selectedButton: String = "Workouts" // State variable to track the selected button ("Workouts" or "Food")
    @EnvironmentObject var workoutData: WorkoutData // Environment object to access the workout data
    
    let weekDays = ["M", "T", "W", "Th", "F", "S", "Su"] // Array of weekdays
    
    var body: some View {
        NavigationView { // NavigationView to enable navigation to other views
            ZStack { // ZStack to overlay views
                Color(red: 27/255, green: 178/255, blue: 115/255) // Background color
                    .ignoresSafeArea() // Extend background color to the edges of the screen
                
                VStack(spacing: 0) {
                    VStack(spacing: 0) {
                        HStack { // Header with title and menu icon
                            Spacer()
                            Text("Plan") // Title text
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .bold()
                            Spacer()
                            Image(systemName: "line.horizontal.3") // Menu icon
                                .foregroundColor(.white)
                                .padding(.trailing, 20)
                        }
                        .padding(.top, 50)
                        
                        Text("Plan Type Week") // Subtitle text
                            .foregroundColor(.white)
                            .padding(.bottom, 10)
                            .bold()
                    }
                    .background(Color(red: 27/255, green: 178/255, blue: 115/255)) // Background color for header
                    
                    VStack { // Main content area
                        HStack { // Weekday selection
                            ForEach(weekDays, id: \.self) { day in
                                Text(day)
                                    .frame(width: 45, height: 30)
                                    .background(selectedDay == day ? Color.green : Color.clear) // Highlight selected day
                                    .cornerRadius(15)
                                    .onTapGesture {
                                        self.selectedDay = day // Update selected day
                                    }
                            }
                        }
                        .padding(.top, 10)
                        
                        HStack { // Button selection for "Workout" and "Food"
                            NavigationLink(destination: WorkoutsView(selectedDay: $selectedDay)) { // Navigate to WorkoutsView
                                Text("Workout")
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(width: 150, height: 40)
                                    .background(selectedButton == "Workout" ? Color.green : Color(red: 226/255, green: 234/255, blue: 226/255)) // Highlight selected button
                                    .cornerRadius(20.0)
                            }
                            
                            Button(action: {
                                self.selectedButton = "Food" // Update selected button
                            }) {
                                Text("Food")
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(width: 150, height: 40)
                                    .background(selectedButton == "Food" ? Color.green : Color(red: 226/255, green: 234/255, blue: 226/255)) // Highlight selected button
                                    .cornerRadius(20.0)
                            }
                        }
                        .padding(.vertical, 10)
                        
                        VStack(alignment: .leading) { // Display exercises for the selected day
                            Text("Exercise") // Title for exercise section
                                .font(.title)
                                .padding(.bottom, 2)
                                .foregroundColor(.black)
                            
                            ScrollView { // Scrollable list of exercises
                                if let exercises = workoutData.selectedExercises[selectedDay] { // Check if there are exercises for the selected day
                                    ForEach(exercises) { exercise in
                                        Text(exercise.name) // Display exercise name
                                            .padding()
                                            .background(Color.white)
                                            .cornerRadius(10)
                                            .padding(.horizontal, 20)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    .background(Color.white) // Background color for main content
                    .cornerRadius(20)
                    .padding(.horizontal, 10)
                    .padding(.bottom, 10)
                }
                .padding(.bottom, 5)
            }
        }
    }
}

struct CalendarPage_Previews: PreviewProvider {
    static var previews: some View {
        CalendarPage().environmentObject(WorkoutData()) // Provide WorkoutData environment object for preview
    }
}
