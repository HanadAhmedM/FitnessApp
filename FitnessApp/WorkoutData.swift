//
//  WorkoutData.swift
//  FitnessApp
//
//  Created by Elin.Andersson on 2024-05-21.

//hanterar en användares träningspass och övningar, och två strukturer NamedWorkout och Exercise för att representera träningspass och övningar.

import Foundation
import SwiftUI

class WorkoutData: ObservableObject {
    @Published var selectedExercises: [String: [NamedWorkout]] = [:]
    
    init() {
        loadWorkouts()
    }
    
    func addExercise(_ exercise: Exercise, to day: String, name: String) {
        if selectedExercises[day] != nil {
            if let index = selectedExercises[day]?.firstIndex(where: { $0.name == name }) {
                selectedExercises[day]?[index].exercises.append(exercise)
            } else {
                selectedExercises[day]?.append(NamedWorkout(name: name, exercises: [exercise]))
            }
        } else {
            selectedExercises[day] = [NamedWorkout(name: name, exercises: [exercise])]
        }
        saveWorkouts()
    }
    
    func deleteExercise(_ exercise: Exercise, from day: String, name: String) {
        guard var workouts = selectedExercises[day] else { return }
        if let index = workouts.firstIndex(where: { $0.name == name }) {
            workouts[index].exercises.removeAll { $0.id == exercise.id }
            if workouts[index].exercises.isEmpty {
                workouts.remove(at: index)
            }
        }
        if workouts.isEmpty {
            selectedExercises.removeValue(forKey: day)
        } else {
            selectedExercises[day] = workouts
        }
        saveWorkouts()
    }
    
    func saveWorkouts() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(selectedExercises) {
            UserDefaults.standard.set(encoded, forKey: "savedWorkouts")
        }
    }
    
    func loadWorkouts() {
        if let savedWorkouts = UserDefaults.standard.data(forKey: "savedWorkouts") {
            let decoder = JSONDecoder()
            if let loadedWorkouts = try? decoder.decode([String: [NamedWorkout]].self, from: savedWorkouts) {
                selectedExercises = loadedWorkouts
            }
        }
    }
}

struct NamedWorkout: Identifiable, Codable {
    var id = UUID()
    var name: String
    var exercises: [Exercise]
}
/*struct ExerciseType: Identifiable, Codable {
    var id = UUID()
    var name: String
    var description: String
}*/


