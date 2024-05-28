import SwiftUI

struct CalendarPage: View {
    @State private var selectedDay: String? = ""
    @State private var selectedExerciseToday: String = ""
    @State private var workouts: [Exercise] = []
    @State private var selectedButton: String = "Workout"
    @State private var navigateToWorkoutsView = false
    @EnvironmentObject var workoutData: WorkoutData
    private var exerciseDay: String? = ""
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
                                Button(action: {
                                    selectedDay = day
                                    selectedExerciseToday = day
                                   
                                }) {
                                    Text(day)
                                        .frame(width: 45, height: 30)
                                        .foregroundColor(.black)
                                        .font(.headline)
                                        .background(selectedDay == day ? Color.green : Color.clear)
                                        .cornerRadius(15)
                                }
                            }
                        }
                        .padding(.top, 10)

                        HStack {
                            Button(action: {
                                selectedButton = "Workout"
                                navigateToWorkoutsView = true
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
                                selectedButton = "Food"
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
                                
                                Spacer()
                                
                                ScrollView {
                                    if let exercises = workoutData.selectedExercises[selectedExerciseToday], !exercises.isEmpty {
                                        ForEach(exercises) { exercise in
                                            VStack(alignment: .leading) {
                                                HStack(spacing: 50) {
                                                    Image(exercise.name)
                                                        .resizable()
                                                        .frame(width: 100, height: 100)
                                                    VStack {
                                                        Text(exercise.name)
                                                            .font(.title)
                                                            .padding(.bottom, 2)
                                                            .padding(.horizontal, -10)
                                                            .foregroundColor(.black)
                                                            .onAppear(){
                                                                if let selectedDay = selectedDay {
                                                                    updateExerciseDay(exerciseName:exercise.name)
                                                                }
                                                            }
                                                        Text(fullDayName(from: selectedDay))
                                                            .font(.title2)
                                                            .foregroundColor(.gray)
                                                            .padding(.bottom, 5)
                                                    }
                                                }
                                                .frame(height: 70)
                                                
                                                List(workouts, id: \.id) { exercise in
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
                                                        .background(Color(hex: "E2EAE2"))
                                                        .frame(width: 300, height: 100)
                                                        .cornerRadius(10)
                                                    }
                                                }
                                                .listStyle(PlainListStyle())
                                                .frame(width: 300, height: 5000, alignment: .center)
                                            }
                                        }
                                    } else {
                                        VStack(alignment: .leading) {
                                            HStack {
                                                Image(systemName: "figure")
                                                    .resizable()
                                                    .frame(width: 70, height: 70)
                                                    .padding(.leading, 1)
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
                                            ScrollView{
                                                Text("No workout chosen")
                                                    .foregroundColor(.gray)
                                                    .italic()
                                                    .padding(.top, 20)
                                            }
                                            
                                        }
                                        
                                      
                                        
                                    }
                                }
                                }
                        } else if selectedButton == "Food" {
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(systemName: "fork.knife.circle")
                                        .resizable()
                                        .frame(width: 70, height: 70)
                                        .padding(.leading, -90)
                                    VStack {
                                        Text("Food")
                                            .font(.title)
                                            .padding(.bottom, 2)
                                            .padding(.horizontal, -20)
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
                }
            }
        }
    }

    func fullDayName(from abbreviation: String?) -> String {
        guard let abbreviation = abbreviation else { return "" }
        switch abbreviation {
        case "M": return "Monday"
        case "T": return "Tuesday"
        case "W": return "Wednesday"
        case "Th": return "Thursday"
        case "F": return "Friday"
        case "S": return "Saturday"
        case "Su": return "Sunday"
        default: return ""
        }
    }
    func updateExerciseDay(exerciseName: String) {
        self.fetchData(for: exerciseName)
        print("Uddated Exercise")
    }
}

struct CalendarPage_Previews: PreviewProvider {
    static var previews: some View {
        CalendarPage().environmentObject(WorkoutData())
    }
}
