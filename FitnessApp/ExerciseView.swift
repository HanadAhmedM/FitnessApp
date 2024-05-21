//
//  ExerciseView.swift
//  FitnessApp
//
//  Created by Elin.Andersson on 2024-05-13.
//Tillfällig exercise sida som förklarar varje övning hårkodad exercise med bild och text

import Foundation
import SwiftUI

struct ExerciseView: View {
    let exercise: Exercise
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(exercise.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .padding()
            
            Text(exercise.name)
                .font(.largeTitle)
                .bold()
                .padding([.top, .bottom])
            
            Text(exercise.description)
                .padding([.leading, .trailing, .bottom]) // Add padding to the leading, trailing, and bottom edges
            
            Spacer() // Add a spacer to push the content to the top
        }
        .navigationTitle(exercise.name) // Set the navigation title to the exercise name
        .padding() // Add padding around the entire VStack
    }
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

