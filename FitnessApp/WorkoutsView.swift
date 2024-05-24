//
//  WorkoutsView.swift
//  FitnessApp
//
//  Created by Elin.Andersson on 2024-05-21.
//

import SwiftUI
import Foundation

struct WorkoutsView: View {
    @Binding var selectedDay: String // Binding for tracking the selected day
    @EnvironmentObject var workoutData: WorkoutData // Environment object for sharing workout data across views
    @State private var navigateToNamingView = false // State for controlling navigation to naming view
    @State private var selectedExercise: Exercise? // State for tracking the selected exercise
    @State private var showWorkoutNameDialog = false // State for controlling the display of workout name dialog
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 27/255, green: 178/255, blue: 115/255).ignoresSafeArea() // Background color
                VStack {
                    Text("Workouts")
                        .font(.system(size: 24, weight: .bold))
                        .padding(.top, 20)
                        .foregroundColor(.white)
                    
                    ScrollView { // Scrollable list
                        VStack {
                            
                            NavigationLink(
                                destination: ExercisesListView(selectedExercise: $selectedExercise)
                                    .environmentObject(workoutData)) {
                                        VStack(alignment: .leading) {
                                            Text("Custom Mode")
                                                .font(.system(size: 24, weight: .bold))
                                                .foregroundColor(.black)
                                            HStack {
                                                Text("Create your own workout")
                                                    .font(.system(size: 16))
                                                    .foregroundColor(.black)
                                                Spacer()
                                                NavigationLink(destination: WorkoutsChooseExerciseView(selectedDay: $selectedDay)) {
                                                    
                                                    Image(systemName: "plus.app")
                                                        .resizable()
                                                        .frame(width: 25, height: 25)
                                                        .background(Color.white)
                                                }
                                            }
                                            .padding(.top, 10)
                                        }
                                        .padding()
                                        .frame(maxWidth: .infinity, minHeight: 100, alignment: .leading)
                                        .background(Color(red: 156/255, green: 216/255, blue: 191/255)) // Light green background
                                        .cornerRadius(15)
                                        .padding(.horizontal)
                                    }
                            if let workouts = workoutData.selectedExercises[selectedDay], !workouts.isEmpty {
                                ForEach(workouts) { workout in
                                    VStack(alignment: .leading) {
                                        Text(workout.name)
                                            .font(.headline)
                                            .padding(.bottom, 5)
                                        ForEach(workout.exercises) { exercise in
                                            Text(exercise.name)
                                                .padding()
                                                .background(Color.white)
                                                .cornerRadius(10)
                                                .padding(.horizontal, 20)
                                        }
                                    }
                                    .padding(.bottom, 10)
                                }
                            } else {
                                Text("No workout chosen")
                                    .foregroundColor(.gray)
                                    .italic()
                                    .padding(.top, 20)
                            }
                        }
                    }
                    
                    // Embed ExercisesListView directly in WorkoutsView
                  ExercisesListView(selectedExercise: $selectedExercise)
                      .environmentObject(workoutData)
                      .frame(height: 500) // Adjust the height as needed
                       .padding(.top, 10)
            
            .padding()
            .background(Color.white)
            .cornerRadius(30)
            .padding()
        }
    }
        .navigationBarHidden(true)
}
}
}

struct WorkoutsView_Previews: PreviewProvider {
    @State static var selectedDay = "M"
    
    static var previews: some View {
        WorkoutsView(selectedDay: $selectedDay)
            .environmentObject(WorkoutData())
    }
}
