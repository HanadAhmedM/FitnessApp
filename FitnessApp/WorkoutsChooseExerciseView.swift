import SwiftUI
import Foundation

struct WorkoutsChooseExerciseView: View {
    @Binding var selectedDay: String?
    @EnvironmentObject var workoutData: WorkoutData
    @State private var navigateToNamingView = false
    @State private var selectedExercise: String?
    @State private var showWorkoutNameDialog = false

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 27/255, green: 178/255, blue: 115/255).ignoresSafeArea()
                VStack {
                    Text("Custom Mode")
                        .font(.system(size: 24, weight: .bold))
                        .padding(.top, 20)
                        .foregroundColor(.white)
                    
                    ScrollView {
                        VStack(alignment: .leading) {
                            Text("Custom Name")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                            
                            if let selectedExercise = selectedExercise {
                                Text(selectedExercise)
                                    .font(.headline)
                                    .foregroundColor(.blue)
                                    .padding(.bottom, 20)
                            }
                            
                            Button(action: {
                                navigateToNamingView = true
                            }) {
                                Text("Select Exercise")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                            .sheet(isPresented: $navigateToNamingView) {
                                WorkoutNamingView(selectedDay: $selectedDay, selectedExercise: $selectedExercise)
                            }
                            
                            Button(action: {
                                if let selectedDay = selectedDay, let selectedExercise = selectedExercise {
                                    workoutData.addExercise(selectedExercise, to: selectedDay, name: "Custom Workout")
                                    self.selectedExercise = nil
                                }
                            }) {
                                Text("Save Workout")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.green)
                                    .cornerRadius(10)
                            }
                        }
                        .padding()
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(30)
                    .padding()
                }
            }
        }
    }
}

struct WorkoutsChooseExerciseView_Previews: PreviewProvider {
    @State static var selectedDay: String? = "M"
    
    static var previews: some View {
        WorkoutsChooseExerciseView(selectedDay: $selectedDay)
            .environmentObject(WorkoutData())
    }
}

