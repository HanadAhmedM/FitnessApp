//
//  ExerciseListView.swift
//  FitnessApp
//
//  Created by Elin.Andersson on 2024-05-13.
//Tillfällig scrollbar lista med hårdkodade exercises

import SwiftUI
import Foundation
struct ExercisesListView: View {
    @EnvironmentObject var workoutData: WorkoutData
    @Binding var selectedDay: String
    @Binding var selectedExercise: Exercise?
    @Binding var showWorkoutNameDialog: Bool
    @Binding var navigateToNamingView: Bool
    
    let exercises: [Exercise] = [
        Exercise(name: "Jumping Jacks", description: "Jumping Jacks - Start with your feet together and your hands at your sides, then jump with your legs spread wide and your hands touching overhead.", imageName: "jumpingjacks"),
        Exercise(name: "Burpees", description: "Burpees - From a standing position, drop into a squat with your hands on the ground, then kick your feet back into a push-up position. Complete one push-up, then immediately return your feet to the squat position and jump up.", imageName: "burpees"),
        Exercise(name: "High Pull", description: "High Pull - Stand with your feet hip-width apart, holding a kettlebell in front of your thighs. Lift the kettlebell to your chest, leading with your elbows, and then lower it back down.", imageName: "highpull"),
        Exercise(name: "Squats", description: "Squats - Stand with feet hip-width apart and squat down as if sitting in a chair, keeping your knees behind your toes.", imageName: "squats"),
        Exercise(name: "Lunges", description: "Lunges - Step forward with one leg and lower your hips until both knees are bent at a 90-degree angle.", imageName: "lunges"),
        Exercise(name: "Plank", description: "Plank - Maintain a push-up position without letting your hips sag or lift.", imageName: "plank"),
        Exercise(name: "Crunches", description: "Crunches - Lie on your back with your knees bent and lift your shoulders off the floor.", imageName: "crunches"),
        Exercise(name: "Mountain Climbers", description: "Mountain Climbers - Start in a plank position and alternate bringing your knees forward to your chest.", imageName: "mountainclimbers"),
        Exercise(name: "Push-Ups", description: "Push-Ups - Keep your body straight and lower it to the ground by bending your arms.", imageName: "pushups"),
        Exercise(name: "Russian Twists", description: "Russian Twists - Sit on the floor with your legs bent, lean back slightly, and twist your torso from side to side.", imageName: "russiantwists"),
        Exercise(name: "Leg Raises", description: "Leg Raises - Lie on your back, legs straight, and raise your legs to 90 degrees without bending the knees.", imageName: "legraises"),
        Exercise(name: "Sit-Ups", description: "Sit-Ups - Lie on your back, bend your legs, and lift your upper body all the way up towards your knees.", imageName: "situps"),
        Exercise(name: "Tricep Dips", description: "Tricep Dips - Use a chair or bench to lower your body by bending your arms, then push back up.", imageName: "tricepdips"),
        Exercise(name: "Box Jumps", description: "Box Jumps - Stand in front of a sturdy box and jump onto it with both feet, then jump back down.", imageName: "boxjumps"),
        Exercise(name: "Pull-Ups", description: "Pull-Ups - Hang from a bar with your hands shoulder-width apart and pull your body up until your chin is over the bar.", imageName: "pullups")
    ]
    
    var body: some View {
        List(exercises) { exercise in
            HStack {
                NavigationLink(destination: ExerciseView(exercise: exercise)) {
                    HStack {
                        Image(exercise.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .padding()
                            .background(Color(red: 226/255, green: 234/255, blue: 226/255))
                            .cornerRadius(4.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 4.0)
                                    .stroke(Color(red: 27/255, green: 178/255, blue: 115/255), lineWidth: 4)
                            )
                        
                        Text(exercise.name)
                            .foregroundColor(Color.black)
                            .bold()
                        
                        Spacer()
                        
                       // Image(systemName: "chevron.right")
                            .foregroundColor(Color.gray)
                    }
                }
                
                Button(action: {
                    selectedExercise = exercise
                    showWorkoutNameDialog = true
                    navigateToNamingView = true
                }) {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(Color.green)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .navigationTitle("Exercises")
        .bold()
        .padding(.horizontal, 10)
        .padding(.bottom, 10)
        .padding(.top, 10)
        .background(Color(red: 226/255, green: 234/255, blue: 226/255).ignoresSafeArea())
        .cornerRadius(40.0)
        .overlay(
            RoundedRectangle(cornerRadius: 50.0)
                .stroke(Color(red: 27/255, green: 178/255, blue: 115/255), lineWidth: 30)
        )
    }
}
struct ExercisesListView_Previews: PreviewProvider {
    @State static var selectedDay = "M"
    @State static var selectedExercise: Exercise? = nil
    @State static var showWorkoutNameDialog = false
    @State static var navigateToNamingView = false

    static var previews: some View {
        ExercisesListView(
            selectedDay: $selectedDay,
            selectedExercise: $selectedExercise,
            showWorkoutNameDialog: $showWorkoutNameDialog,
            navigateToNamingView: $navigateToNamingView
        ).environmentObject(WorkoutData())
    }
}

/*import Foundation
import SwiftUI

// Vy som visar en lista med övningar
struct ExercisesListView: View {
    let exercises: [Exercise] = [
        Exercise(name: "Jumping Jacks", description: "Jumping Jacks - Start with your feet together and your hands at your sides, then jump with your legs spread wide and your hands touching overhead.", imageName: "jumpingjacks"),
        Exercise(name: "Burpees", description: "Burpees - From a standing position, drop into a squat with your hands on the ground, then kick your feet back into a push-up position. Complete one push-up, then immediately return your feet to the squat position and jump up.", imageName: "burpees"),
        Exercise(name: "High Pull", description: "High Pull - Stand with your feet hip-width apart, holding a kettlebell in front of your thighs. Lift the kettlebell to your chest, leading with your elbows, and then lower it back down.", imageName: "highpull"),
        Exercise(name: "Squats", description: "Squats - Stand with feet hip-width apart and squat down as if sitting in a chair, keeping your knees behind your toes.", imageName: "squats"),
        Exercise(name: "Lunges", description: "Lunges - Step forward with one leg and lower your hips until both knees are bent at a 90-degree angle.", imageName: "lunges"),
        Exercise(name: "Plank", description: "Plank - Maintain a push-up position without letting your hips sag or lift.", imageName: "plank"),
        Exercise(name: "Crunches", description: "Crunches - Lie on your back with your knees bent and lift your shoulders off the floor.", imageName: "crunches"),
        Exercise(name: "Mountain Climbers", description: "Mountain Climbers - Start in a plank position and alternate bringing your knees forward to your chest.", imageName: "mountainclimbers"),
        Exercise(name: "Push-Ups", description: "Push-Ups - Keep your body straight and lower it to the ground by bending your arms.", imageName: "pushups"),
        Exercise(name: "Russian Twists", description: "Russian Twists - Sit on the floor with your legs bent, lean back slightly, and twist your torso from side to side.", imageName: "russiantwists"),
        Exercise(name: "Leg Raises", description: "Leg Raises - Lie on your back, legs straight, and raise your legs to 90 degrees without bending the knees.", imageName: "legraises"),
        Exercise(name: "Sit-Ups", description: "Sit-Ups - Lie on your back, bend your legs, and lift your upper body all the way up towards your knees.", imageName: "situps"),
        Exercise(name: "Tricep Dips", description: "Tricep Dips - Use a chair or bench to lower your body by bending your arms, then push back up.", imageName: "tricepdips"),
        Exercise(name: "Box Jumps", description: "Box Jumps - Stand in front of a sturdy box and jump onto it with both feet, then jump back down.", imageName: "boxjumps"),
        Exercise(name: "Pull-Ups", description: "Pull-Ups - Hang from a bar with your hands shoulder-width apart and pull your body up until your chin is over the bar.", imageName: "pullups")
    ]

    
    var body: some View {
        ZStack{
            Color(red: 27/255, green: 178/255, blue: 115/255)
                .edgesIgnoringSafeArea(.all)
            NavigationView {
        
                List(exercises, id: \.name) { exercise in
                    NavigationLink(destination: ExerciseView(exercise: exercise)) {
                        HStack {
                            Text(exercise.name)
                                .foregroundColor(Color.black)
                                .bold()
                               // .background(Color(red: 226/255, green: 234/255, blue: 226/255))
                            Spacer()
                            VStack{
                                Image(exercise.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .padding()
                                    .background(Color(red: 226/255, green: 234/255, blue: 226/255))
                                    .background(Color .white)
                                    .cornerRadius(4.0)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 4.0)
                                            .stroke(Color(red: 27/255, green: 178/255, blue: 115/255), lineWidth: 4)
                                    )
                            }
                        }
                    }
                    Spacer()
                }
              
                
                .navigationTitle("Exercises")
                .bold()
                .background(Color(red: 27/255, green: 178/255, blue: 115/255))
                .padding(.horizontal,10)
                .padding(.bottom,10)
                .padding(.top,10)
                //.padding()
                .background(Color(red: 27/255, green: 178/255, blue: 115/255))
                
                .background(Color(red: 226/255, green: 234/255, blue: 226/255).ignoresSafeArea())
               // .padding(.bottom,60)
                .cornerRadius(40.0)
                 .overlay(
                 RoundedRectangle(cornerRadius: 50.0)
                 .stroke(Color(red: 27/255, green: 178/255, blue: 115/255), lineWidth: 30)
                 )
                
            }
          }
      }
  }

  // Förhandsvisning
  struct ExercisesListView_Previews: PreviewProvider {
      static var previews: some View {
          ExercisesListView()
         
      }
  }*/
    
    
    
/* ZStack {
    Color(red: 27/255, green: 178/255, blue: 115/255).edgesIgnoringSafeArea(.all)
    
    
    

    var body: some View {
        NavigationView {
            VStack{
                Text("Exercises")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 10)
                                    .background(Color.gray)
                                    .cornerRadius(20)
                                    .padding(.horizontal, 10)
                
                List(exercises, id: \.name) { exercise in
                                   NavigationLink(destination: ExerciseView(exercise: exercise)) {
                                       Text(exercise.name)
                                           .padding()
                                           .frame(maxWidth: .infinity, alignment: .leading)
                                           .background(Color.white)
                                           .cornerRadius(10)
                                           .shadow(radius: 2)
                                   }
                               }
                               .listStyle(PlainListStyle())
                               .cornerRadius(20)
                               .padding(.horizontal, 10)
                           }
                           .background(Color(red: 27/255, green: 178/255, blue: 115/255).edgesIgnoringSafeArea(.all))
                           .navigationBarHidden(true)
                       }
                   }
               }

                List(exercises, id: \.name) { exercise in
                    NavigationLink(destination: ExerciseView(exercise: exercise)) {
                        HStack {
                            Text(exercise.name)
                                .foregroundColor(Color.black)
                            Spacer()
                            Image(exercise.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .padding()
                                .background(Color(red: 226/255, green: 234/255, blue: 226/255))
                                .cornerRadius(4.0)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4.0)
                                        .stroke(Color(red: 27/255, green: 178/255, blue: 115/255), lineWidth: 4)
                                )
                        }
                    }
                }
                .navigationTitle("Exercises")
                .font(.system(size: 24, weight: .bold))
                .padding(.horizontal,10)
                .padding(.bottom,200)
                .padding(.top,40)
                .background((Color(red: 27/255, green: 178/255, blue: 115/255)))

                //.background(Color(red: 226/255, green: 234/255, blue: 226/255))
                .cornerRadius(20.0)
                .overlay(
                    RoundedRectangle(cornerRadius: 20.0)
                        .stroke(Color(red: 27/255, green: 178/255, blue: 115/255), lineWidth: 40)
                        .cornerRadius(40.0)
                )
               // .background(Color(red: 226/255, green: 234/255, blue: 226/255))

        
            }
        }
    }
}

// Förhandsvisning
struct ExercisesListView_Previews: PreviewProvider {
    static var previews: some View {
        ExercisesListView()
    }
 }*/
