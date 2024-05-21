//
//  WorkoutNamingData.swift
//  FitnessApp
//
//  Created by Elin.Andersson on 2024-05-21.
//
//en vy där användaren kan namnge sin workout och lägga till övningar.

import SwiftUI
import Foundation

struct WorkoutNamingView: View {
    @EnvironmentObject var workoutData: WorkoutData
    @Binding var selectedDay: String
    @Binding var selectedExercise: Exercise?
    @State private var workoutName: String = ""
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            TextField("Enter Workout Name", text: $workoutName)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .padding(.horizontal, 20)
            
            if let exercise = selectedExercise {
                Button(action: {
                    if !workoutName.isEmpty {
                        workoutData.addExercise(exercise, to: selectedDay, name: workoutName)
                        showingAlert = true
                        selectedExercise = nil
                    }
                }) {
                    Text("Save Workout")
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                .alert(isPresented: $showingAlert) {
                    Alert(
                        title: Text("Workout Saved"),
                        message: Text("\(workoutName) has been saved."),
                        dismissButton: .default(Text("OK")) {
                            workoutName = ""
                        }
                    )
                }
            }
            
            Spacer()
        }
        .navigationTitle("Name Your Workout")
        .padding()
        .onAppear {
            if let exercise = selectedExercise {
                workoutName = "\(exercise.name) Workout"
            }
        }
    }
}

struct WorkoutNamingView_Previews: PreviewProvider {
    @State static var selectedDay = "M"
    @State static var selectedExercise: Exercise? = Exercise(name: "Sample Exercise", description: "This is a sample description.", imageName: "sampleImage")
    static var previews: some View {
        WorkoutNamingView(
            selectedDay: $selectedDay,
            selectedExercise: $selectedExercise
        ).environmentObject(WorkoutData())
    }
}

