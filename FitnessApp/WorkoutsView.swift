//
//  WorkoutsView.swift
//  FitnessApp
//
//  Created by Elin.Andersson on 2024-05-21.
//

//en tillfällig(?) view som visar en lista med träningsövningar och tillåter användaren att navigera till andra vyer för att lägga till och namnge träningspass.

import SwiftUI
import Foundation

struct WorkoutsView: View {
    @Binding var selectedDay: String // Binding för att hålla reda på den valda dagen
    @EnvironmentObject var workoutData: WorkoutData // Miljöobjekt för att dela träningsdata över flera vyer
    @State private var navigateToNamingView = false // State för att styra navigeringen till namnvy
    @State private var selectedExercise: Exercise? // State för att hålla reda på den valda övningen
    @State private var showWorkoutNameDialog = false // State för att styra visningen av dialogrutan för träningsnamn

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 27/255, green: 178/255, blue: 115/255).ignoresSafeArea()
                VStack {
                    Text("Workouts")
                        .font(.system(size: 24, weight: .bold))
                        .padding(.top, 20)
                        .foregroundColor(.white)
                    
                    List { //scrollningsbar lista
                        NavigationLink(destination: ExercisesListView(selectedDay: $selectedDay, selectedExercise: $selectedExercise, showWorkoutNameDialog: $showWorkoutNameDialog, navigateToNamingView: $navigateToNamingView)) {
                            HStack {
                                Image(systemName: "circle.fill")
                                    .foregroundColor(.green)
                                Text("Exercises List")
                            }
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(30)
                    .padding()
                    
                    NavigationLink(destination: WorkoutNamingView(selectedDay: $selectedDay, selectedExercise: $selectedExercise).environmentObject(workoutData),
                        isActive: $navigateToNamingView) {
                        EmptyView()
                    }
                }
            }
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

