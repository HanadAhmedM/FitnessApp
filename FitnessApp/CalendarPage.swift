import SwiftUI

struct CalendarPage: View {
    @State private var selectedDay: String = "M"
    @State private var selectedButton: String = "Workouts"
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
                            NavigationLink(destination: WorkoutsView(selectedDay: $selectedDay)) {
                                Text("Workout")
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(width: 150, height: 40)
                                    .background(selectedButton == "Workout" ? Color.green : Color(red: 226/255, green: 234/255, blue: 226/255))
                                    .cornerRadius(20.0)
                            }
                            
                            NavigationLink(destination: RecepiesView(selectedDay: $selectedDay)) {
                                Text("Food")
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(width: 150, height: 40)
                                    .background(selectedButton == "Food" ? Color.green : Color(red: 226/255, green: 234/255, blue: 226/255))
                                    .cornerRadius(20.0)
                            }
                        }
                        .padding(.vertical, 10)
                        
                        VStack(alignment: .leading) {
                            Text("Exercise")
                                .font(.title)
                                .padding(.bottom, 2)
                                .foregroundColor(.black)
                            
                            Text(fullDayName(from: selectedDay))
                                .font(.title2)
                                .foregroundColor(.gray)
                                .padding(.bottom, 5)
                            
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

