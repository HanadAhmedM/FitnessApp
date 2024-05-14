//
//  ExerciseView.swift
//  FitnessApp
//
//  Created by Elin.Andersson on 2024-05-13.
//

import Foundation
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


