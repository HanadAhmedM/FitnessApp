import SwiftUI
import Foundation

struct WorkoutsView: View {
    @Binding var selectedDay: String? // Change to optional Binding
    @EnvironmentObject var workoutData: WorkoutData
    @State private var navigateToNamingView = false
    @State private var selectedExercise: String?
    @State private var showWorkoutNameDialog = false

    var body: some View {
        NavigationView {
     
            ZStack {
                Color(red: 27/255, green: 178/255, blue: 115/255).ignoresSafeArea() // Background color
                VStack {
                    Text("Workouts")
                        .font(.system(size: 24, weight: .bold))
                        .padding(.top, 20)
                        .foregroundColor(.white)
                    
                
                        VStack {
                            NavigationLink(
                                destination: ExercisesListView(selectedExercise: Optional($selectedExercise)!, selectedDay: $selectedDay) // Wrap selectedDay binding in Optional
                                    .environmentObject(workoutData)
                            ) {
                                VStack(alignment: .leading) {
                                    Text("Custom Mode")
                                        .font(.system(size: 24, weight: .bold))
                                        .foregroundColor(.black)
                                    HStack {
                                        Text("Create your own workout")
                                            .font(.system(size: 16))
                                            .foregroundColor(.black)
                                        Spacer()
                                        Image(systemName: "plus.app")
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                            .background(Color.white)
                                    }
                                    .padding(.top, 10)
                                }
                                .padding()
                                .frame(maxWidth: .infinity, minHeight: 100, alignment: .leading)
                                .background(Color(red: 156/255, green: 216/255, blue: 191/255)) // Light green background
                                .cornerRadius(15)
                                .padding(.horizontal)
                            }

                            // Embed ExercisesListView directly in WorkoutsView
                            ExercisesListView(selectedExercise: Optional($selectedExercise)!, selectedDay: $selectedDay) // Wrap selectedDay binding in Optional
                                .environmentObject(workoutData)
                                .frame(height: 600) // Adjust the height as needed
                                .padding(.top, 10)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(30)
                    .padding()
                }
            }
            
        }
    }


struct WorkoutsView_Previews: PreviewProvider {
    @State static var selectedDay: String? = ""

    static var previews: some View {
        WorkoutsView(selectedDay: $selectedDay)
            .environmentObject(WorkoutData())
    }
}
