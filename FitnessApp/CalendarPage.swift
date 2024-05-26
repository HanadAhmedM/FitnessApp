//
//  CalendarPage.swift
//  FitnessApp
//
//  Created by Elin.Andersson on 2024-05-21.
//
import Foundation
import SwiftUI

struct CalendarPage: View {
    @State private var selectedDay: String = "M"
    @State private var selectedButton: String = "Workout"
    @EnvironmentObject var workoutData: WorkoutData
    @State private var navigateToWorkoutsView = false

    let weekDays = ["M", "T", "W", "Th", "F", "S", "Su"]

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 27/255, green: 178/255, blue: 115/255)
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    VStack(spacing: 0) {
                        HStack {
                            Spacer()
                            Text("Plan")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .bold()
                            Spacer()
                            Image(systemName: "line.horizontal.3")
                                .foregroundColor(.white)
                                .padding(.trailing, 20)
                        }
                        .padding(.top, 50)

                        Text("Plan Type Week")
                            .foregroundColor(.white)
                            .padding(.bottom, 10)
                            .bold()
                    }
                    .background(Color(red: 27/255, green: 178/255, blue: 115/255))

                    VStack {
                        HStack {
                            ForEach(weekDays, id: \.self) { day in
                                Text(day)
                                    .frame(width: 45, height: 30)
                                    .background(selectedDay == day ? Color.green : Color.clear)
                                    .cornerRadius(15)
                                    .onTapGesture {
                                        self.selectedDay = day
                                    }
                            }
                        }
                        .padding(.top, 10)

                        HStack {
                            Button(action: {
                                self.selectedButton = "Workout"
                               // self.navigateToWorkoutsView = true
                            }) {
                                Text("Workout")
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(width: 150, height: 40)
                                    .background(selectedButton == "Workout" ? Color.green : Color(red: 226/255, green: 234/255, blue: 226/255))
                                    .cornerRadius(20.0)
                            }
                            .background(
                                NavigationLink(destination: WorkoutsView(selectedDay: $selectedDay)
                                    .environmentObject(workoutData), isActive: $navigateToWorkoutsView) {
                                        EmptyView()
                                    }
                            )

                            Button(action: {
                                self.selectedButton = "Food"
                            }) {
                                Text("Food")
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(width: 150, height: 40)
                                    .background(selectedButton == "Food" ? Color.green : Color(red: 226/255, green: 234/255, blue: 226/255))
                                    .cornerRadius(20.0)
                            }
                        }
                        .padding(.vertical, 10)

                        if selectedButton == "Workout" {
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(systemName: "figure")
                                        .resizable()
                                        .frame(width: 70, height: 70)
                                        .padding(.leading,-90)
                                    VStack{
                                    Text("Exercise")
                                        .font(.title)
                                        .padding(.bottom, 2)
                                        .foregroundColor(.black)
                                    
                      
                                        Text(fullDayName(from: selectedDay))
                                            .font(.title2)
                                            .foregroundColor(.gray)
                                            .padding(.bottom, 10)
                                    }
                                    
                                }
                                Spacer()
                                
                                ScrollView {
                                    if let workouts = workoutData.selectedExercises[selectedDay], !workouts.isEmpty {
                                        ForEach(workouts) { workout in
                                            VStack(alignment: .leading) {
                                                Text(workout.name)
                                                    .font(.headline)
                                                    .padding(.bottom, 5)
                                                ForEach(workout.exercises) { exercise in
                                                    Text(exercise.name)
                                                        .padding()
                                                        .background(Color.white)
                                                        .cornerRadius(10)
                                                        .padding(.horizontal, 20)
                                                }
                                            }
                                            .padding(.bottom, 10)
                                        }
                                    } else {
                                        Text("No workout chosen")
                                            .foregroundColor(.gray)
                                            .italic()
                                            .padding(.top, 20)
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        } else if selectedButton == "Food" {
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(systemName: "fork.knife.circle")
                                        .resizable()
                                        .frame(width: 70, height: 70)
                                        .padding(.leading,-90)
                                    VStack {
                                        Text("Food")
                                            .font(.title)
                                            .padding(.bottom, 2)
                                            .padding(.horizontal, -40)
                                            .foregroundColor(.black)
                                        
                                        Text(fullDayName(from: selectedDay))
                                            .font(.title2)
                                            .foregroundColor(.gray)
                                            .padding(.bottom, 5)
                                    }
                                }
                                ScrollView {
                                    Text("No chosen food") // Replace with actual food data
                                        .foregroundColor(.gray)
                                        .italic()
                                        .padding(.top, 20)
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.horizontal, 10)
                    .padding(.bottom, 10)
                }
                .padding(.bottom, 5)
            }
            .navigationBarHidden(true)
        }
    }

    func fullDayName(from shortName: String) -> String {
        switch shortName {
        case "M":
            return "Monday"
        case "T":
            return "Tuesday"
        case "W":
            return "Wednesday"
        case "Th":
            return "Thursday"
        case "F":
            return "Friday"
        case "S":
            return "Saturday"
        case "Su":
            return "Sunday"
        default:
            return shortName
        }
    }
}

struct CalendarPage_Previews: PreviewProvider {
    static var previews: some View {
        CalendarPage().environmentObject(WorkoutData())
    }
}
