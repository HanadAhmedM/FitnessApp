//
//  WorkoutsChooseExerciseView.swift
//  FitnessApp
//
//  Created by Elin.Andersson on 2024-05-23.
//


import SwiftUI
import Foundation

struct WorkoutsChooseExerciseView: View {
    @Binding var selectedDay: String // Binding för att hålla reda på den valda dagen
    @EnvironmentObject var workoutData: WorkoutData // Miljöobjekt för att dela träningsdata över flera vyer
    @State private var navigateToNamingView = false // State för att styra navigeringen till namnvy
    @State private var selectedExercise: Exercise? // State för att hålla reda på den valda övningen
    @State private var showWorkoutNameDialog = false // State för att styra visningen av dialogrutan för träningsnamn

    var body: some View {
        
        NavigationView {
            ZStack {
                Color(red: 27/255, green: 178/255, blue: 115/255).ignoresSafeArea()//bakgrundsgrön
                VStack {
                    Text("Custom Mode")
                        .font(.system(size: 24, weight: .bold))
                        .padding(.top, 20)
                        .foregroundColor(.white)
                    
                    
                            ScrollView { //scrollningsbar lista
                                NavigationLink(destination: ExercisesListView(selectedDay: $selectedDay, selectedExercise: $selectedExercise, showWorkoutNameDialog: $showWorkoutNameDialog, navigateToNamingView: $navigateToNamingView)) {
                                    VStack(alignment: .leading) {
                                        Text("Custom Name")
                                        //.font(.headline)
                                            .font(.system(size: 20))
                                            .foregroundColor(.black)
                                        
                                        
                                        //ÄNDRA ExercisesListView TILL HANADS SIDA:
                                        NavigationLink(destination: ExercisesListView(selectedDay: $selectedDay, selectedExercise: $selectedExercise, showWorkoutNameDialog: $showWorkoutNameDialog, navigateToNamingView: $navigateToNamingView)) {
                                            
                                            Image(systemName: "plus.app")
                                                .resizable()
                                                .frame(width: 25, height: 25)
                                                .background(Color.white)
                                                .padding(.leading,250)
                                        }
                                        Spacer()
                                        
                                        Text("Exercises")
                                            .font(.system(size: 22, weight: .bold))
                                            .padding(.top, 20)
                                            .foregroundColor(.gray)
                                        ScrollView{
                                            // EXERCISES TO CHOOSE
                                        }

                                       
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity, minHeight: 100, alignment: .leading)
                                    .background(Color.white)
                                    //.cornerRadius(15)
                                    
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
}

struct WorkoutsChooseExerciseView_Previews: PreviewProvider {
    @State static var selectedDay = "M"
    
    static var previews: some View {
        WorkoutsChooseExerciseView(selectedDay: $selectedDay)
            .environmentObject(WorkoutData())
    }
}

