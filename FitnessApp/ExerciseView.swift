//
//  ExerciseView.swift
//  FitnessApp
//
//  Created by Elin.Andersson on 2024-05-13.
//Tillfällig exercise sida som förklarar varje övning hårkodad exercise med bild och text

import Foundation
import SwiftUI

struct ExerciseView: View {
  
    @State private var workouts: [Exercise] = []
    @Binding var bodyPart: String
    
    var body: some View {
            VStack {
                List($workouts, id: \.id) { $exercise in
                    NavigationLink(destination: ExerciseDetailView(exercise: exercise)) {
                        HStack(spacing: 20) {
                            AsyncImage(url: URL(string: exercise.gifUrl)) { image in
                                image.resizable()
                                    .frame(width: 100, height: 100)
                                    .background(Color(hex: "E2EAE2"))
                                    .cornerRadius(8)
                            } placeholder: {
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                            }
                            Text(exercise.name)
                                .font(.system(size: 17, weight: .bold))
                                                                .foregroundColor(Color.black)
                                                               
                                                                   .frame(maxWidth: .infinity) 
                        }
                        
                    }.background(Color(hex: "E2EAE2"))
                        .frame(width: 350,height: 100)
                        .cornerRadius(10)
                }
                
                .listStyle(PlainListStyle())
                
                .onAppear {
                    fetchData()
                }
            }
        }
        
        func fetchData() {
            WorkoutAPI().fetchExercises(for: bodyPart) { result in
                          DispatchQueue.main.async {
                             
                              switch result {
                              case .success(let workouts):
                                  self.workouts = workouts
                              case .failure(let error):
                                  print("Error fetching data:", error)
                                  // Handle error if needed
                              }
                          }
                      }
                  }
              }


    struct ExerciseDetailView: View {
        let exercise: Exercise
        
        var body: some View {
            VStack {
                AsyncImage(url: URL(string: exercise.gifUrl)) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(height: 200)
                } placeholder: {
                    Image(systemName: "photo")
                        .frame(height: 200)
                }
                Text(exercise.name)
                    .font(.title)
                    .padding()
                ForEach(exercise.instructions, id: \.self) { instruction in
                    Text(instruction)
                        .padding()
                }
                Spacer()
            }
            .navigationTitle(exercise.name)
        }
    }
      
#Preview {
 ExerciseView(bodyPart: .constant("back"))
}

   

/*import Foundation
import SwiftUI

// Vy för att visa en enskild övning
struct ExerciseView: View {
    var exercise: Exercise
    @State private var showDescription = false
    
    var body: some View {
        ZStack {
            Color(red: 27/255, green: 178/255, blue: 115/255).edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
            
                    VStack {
                        Image(exercise.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .padding()
                            .background(Color(red: 226/255, green: 234/255, blue: 226/255))
                            .overlay(
                                RoundedRectangle(cornerRadius: 4.0)
                                    .stroke(Color(red: 27/255, green: 178/255, blue: 115/255), lineWidth: 4)
                            )
                            .onTapGesture {
                                withAnimation {
                                    showDescription.toggle()
                                }
                            }
                        
                        if showDescription {
                            Text(exercise.description)
                                .transition(.move(edge: .bottom))
                                .padding()
                                .background(Color(red: 226/255, green: 234/255, blue: 226/255))
                                .cornerRadius(1.0)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 1.0)
                                        .stroke(Color(red: 27/255, green: 178/255, blue: 115/255), lineWidth: 4)
                                )
                        }
                    }
                    Spacer()
                }
                .background(Color(red: 226/255, green: 234/255, blue: 226/255))
                .cornerRadius(30)
            }
        }
    }
*/

