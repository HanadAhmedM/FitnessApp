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
                Color(red: 27/255, green: 178/255, blue: 115/255).ignoresSafeArea()//bakgrundsgrön
                VStack {
                    Text("Workouts")
                        .font(.system(size: 24, weight: .bold))
                        .padding(.top, 20)
                        .foregroundColor(.white)
                    
                    
                    ScrollView { //scrollningsbar lista
                        NavigationLink(destination: ExercisesListView(selectedDay: $selectedDay, selectedExercise: $selectedExercise, showWorkoutNameDialog: $showWorkoutNameDialog, navigateToNamingView: $navigateToNamingView)) {
                            VStack(alignment: .leading) {
                                Text("Custom Mode")
                                    //.font(.headline)
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.black)
                                HStack {
                                    Text("Create your own workout")
                                    // .font(.subheadline)
                                        .font(.system(size: 16))
                                        .foregroundColor(.black)
                                       // .bold()
                                      
                                    //ÄNDRA ExercisesListView TILL HANADS SIDA:
                                    NavigationLink(destination: ExercisesListView(selectedDay: $selectedDay, selectedExercise: $selectedExercise, showWorkoutNameDialog: $showWorkoutNameDialog, navigateToNamingView: $navigateToNamingView)) {
                                        
                                        Image(systemName: "plus.app")
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                            .background(Color.white)
                                            .padding(.leading,70)
                                    }
                                }
                                
                            }
                                .padding()
                                .frame(maxWidth: .infinity, minHeight: 100, alignment: .leading)
                                .background(Color(red: 156/255, green: 216/255, blue: 191/255)) //ljusgrön
                                .cornerRadius(15)
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

struct WorkoutsView_Previews: PreviewProvider {
    @State static var selectedDay = "M"
    
    static var previews: some View {
        WorkoutsView(selectedDay: $selectedDay)
            .environmentObject(WorkoutData())
    }
}

