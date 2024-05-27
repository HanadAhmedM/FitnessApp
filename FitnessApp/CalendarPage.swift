
//
//  CalendarPage.swift
//  FitnessApp
//
//  Created by Elin.Andersson on 2024-05-21.
//
import Foundation
import SwiftUI


struct CalendarPage: View {
    @State private var selectedDay: String? = ""
    @State private var selectedExerciseToday: String = ""
    @State private var workouts: [Exercise] = []
    @State private var selectedButton: String = "Workout"
    @EnvironmentObject var workoutData: WorkoutData
    
    let weekDays = ["M", "T", "W", "Th", "F", "S", "Su"]
    
    var body: some View {
        NavigationView {
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

                        
                        Text("Plan Type Per Week")

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

                                        self.selectedExerciseToday = day // Update selectedExerciseToday when day changes
                                        fetchData(for: selectedExerciseToday) // Fetch exercises for the selected day

                                    }
                            }
                        }
                        .padding(.top, 10)

                        HStack {
                            NavigationLink(
                                destination: WorkoutsView(selectedDay: $selectedDay)) {
                                    Text("Workout")
                                        .foregroundColor(.black)
                                        .padding()
                                        .frame(width: 150, height: 40)
                                        .background(selectedButton == "Workout" ? Color.green : Color(red: 226/255, green: 234/255, blue: 226/255))
                                        .cornerRadius(20.0)
                            }

                        }
                        .padding(.vertical, 10)
                        
                        VStack(alignment: .leading) {
                            if let exercises = workoutData.selectedExercises[selectedExerciseToday] {
                                ForEach(exercises) { exercise in
                                    VStack(alignment: .leading) {
                                        HStack{
                                            
                                            Image(exercise.name)
                                                .resizable()
                                                .frame(width: 70, height: 70)
                                            HStack{
                                                
                                            }
                                            Text(exercise.name)
                                            
                                                .background(Color.white)
                                                .cornerRadius(10)
                                                .padding(.horizontal, 5)
                                                .onTapGesture {
                                                        self.selectedExerciseToday = exercise.name // Update selectedExerciseToday when exercise is tapped
                                                        fetchData(for: exercise.name) // Fetch exercises for the selected exercise
                                                    }
                                        }
                                        .frame(height: 70)
                                  
                                        NavigationView{
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
                                                                    .frame(width: 100, height: 70)
                                                            }
                                                            Text(exercise.name)
                                                                .font(.system(size: 12, weight: .bold))
                                                                .foregroundColor(Color.black)
                                                                .frame(maxWidth: .infinity)
                                                        }
                                                    }.background(Color(hex: "E2EAE2"))
                                                        .frame(width: 300,height: 100)
                                                        .cornerRadius(10)
                                                }
                                                
                                                .listStyle(PlainListStyle())
                                                
                                                .frame(width: 300, height: 200, alignment: .center)
                                            }
                                         
                                        }
                                           
                                       
                                        .padding(.horizontal, 10)

                                    }
                                    .padding(.vertical, 5) // Add vertical padding between exercises
                                }
                            } else {
                                Text("No exercises for this day")
                                    .foregroundColor(.gray)
                            }

                        }.frame(height: 500)
                        .padding(.horizontal, 20)

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
    
    func fetchData(for exerciseName: String) {
        WorkoutAPI().fetchExercises(for: exerciseName) { result in
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

struct CalendarPage_Previews: PreviewProvider {
    static var previews: some View {
        CalendarPage().environmentObject(WorkoutData())
    }
}
