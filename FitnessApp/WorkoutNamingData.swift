import SwiftUI
import Foundation

struct WorkoutNamingView: View {
    @EnvironmentObject var workoutData: WorkoutData
    @Binding var selectedDay: String?
    @Binding var selectedExercise: String?
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
                        workoutData.addExercise(exercise, to: selectedDay ?? "", name: workoutName)
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
            if let exerciseName = selectedExercise {
                workoutName = "\(exerciseName) Workout"
            }
        }
    }
}

struct WorkoutNamingView_Previews: PreviewProvider {
    @State static var selectedDay: String? = "M" // Make selectedDay an optional string
    
    static var previews: some View {
        WorkoutNamingView(
            selectedDay: $selectedDay, // Pass the optional binding
            selectedExercise: .constant(nil) // Use constant binding for selectedExercise
        ).environmentObject(WorkoutData())
    }
}
