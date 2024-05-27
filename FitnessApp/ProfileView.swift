import Foundation
import SwiftUI

// Define ProfileView
struct ProfileView: View {
    @EnvironmentObject var workoutData: WorkoutData
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 27/255, green: 178/255, blue: 115/255).ignoresSafeArea()
                VStack {
                    ProfileHeaderView()
                    ProfileWorkoutList()
                    Spacer()
                }
            }
        }
    }
}

// Define ProfileHeaderView
struct ProfileHeaderView: View {
    var body: some View {
        Text("Profile")
            .font(.system(size: 24, weight: .bold))
            .padding(.top, 20)
    }
}

// Define ProfileWorkoutList
struct ProfileWorkoutList: View {
    @EnvironmentObject var workoutData: WorkoutData
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(workoutData.selectedExercises.keys.sorted(), id: \.self) { key in
                    ProfileDayWorkoutsView(day: key)
                }
            }
            .padding(.horizontal, 20)
            .background(Color.white)
            .cornerRadius(30)
        }
    }
}

// Define ProfileDayWorkoutsView
struct ProfileDayWorkoutsView: View {
    @EnvironmentObject var workoutData: WorkoutData
    let day: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(day)
                .font(.headline)
                .foregroundColor(.black)
            ForEach(workoutData.selectedExercises[day] ?? [], id: \.id) { workout in
                ProfileWorkoutView(workout: workout, day: day)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }
}

// Define ProfileWorkoutView
struct ProfileWorkoutView: View {
    @EnvironmentObject var workoutData: WorkoutData
    let workout: NamedWorkout
    let day: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(workout.name)
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                Button(action: {
                    deleteWorkout()
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
            }
            ForEach(workout.exercises, id: \.self) { exercise in
                Text(exercise)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }
    
    private func deleteWorkout() {
           // Delete the entire workout for the day
           workoutData.selectedExercises.removeValue(forKey: day)
           workoutData.saveWorkouts()
       }
}

// Define ProfileView_Previews
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(WorkoutData())
    }
}
