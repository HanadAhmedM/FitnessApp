import Foundation
import SwiftUI

class WorkoutData: ObservableObject {
    @Published var selectedExercises: [String: [NamedWorkout]] = [:]
    
    init() {
        loadWorkouts()
    }
    
    func addExercise(_ exercise: String, to day: String, name: String) {
        // Replace any existing exercise for the specified day
        selectedExercises[day] = [NamedWorkout(name: name, exercises: [exercise])]
        saveWorkouts()
    }
    
    func deleteExercise(_ exercise: String, from day: String, name: String) {
        guard var workouts = selectedExercises[day] else { return }
        if let index = workouts.firstIndex(where: { $0.name == name }) {
            workouts[index].exercises.removeAll { $0 == exercise }
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
    var exercises: [String]
}


