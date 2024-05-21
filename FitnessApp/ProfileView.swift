//
//  ProfileView.swift
//  FitnessApp
//
//  Created by Elin.Andersson on 2024-05-21.
//Tillfällig profileView där man kan se hela veckans träningar och radera dem om man vill

import Foundation
import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var workoutData: WorkoutData
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 27/255, green: 178/255, blue: 115/255).ignoresSafeArea()
                VStack {
                  

                    Text("Profile")
                        .font(.system(size: 24, weight: .bold))
                        .padding(.top, 20)
                    
                    Spacer()
                    
                    ScrollView { // Lägg till ScrollView här
                        VStack(spacing: 10) {
                            ForEach(workoutData.selectedExercises.keys.sorted(), id: \.self) { key in
                                VStack(alignment: .leading) {
                                    Text(key)
                                        .font(.headline)
                                        .foregroundColor(.black)
                                    ForEach(workoutData.selectedExercises[key] ?? []) { workout in
                                        VStack(alignment: .leading) {
                                            HStack {
                                                Text(workout.name)
                                                    .font(.headline)
                                                    .foregroundColor(.black)
                                                Spacer()
                                                Button(action: {
                                                    deleteWorkout(day: key, workout: workout)
                                                }) {
                                                    Image(systemName: "trash")
                                                        .foregroundColor(.red)
                                                }
                                            }
                                            ForEach(workout.exercises) { exercise in
                                                Text(exercise.name)
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(10)
                                    }
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                            }
                        }
                        .padding(.horizontal, 20)
                        .background(Color.white)
                        .cornerRadius(30)
                    }
                    
                    Spacer()
                }
            }
        }
    }
    
    private func deleteWorkout(day: String, workout: NamedWorkout) {
        for exercise in workout.exercises {
            workoutData.deleteExercise(exercise, from: day, name: workout.name)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(WorkoutData())
    }
}
