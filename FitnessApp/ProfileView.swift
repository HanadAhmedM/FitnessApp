import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var workoutData: WorkoutData
    @Binding var isLoggedIn: Bool // Binding to handle logged-in status
  

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 27/255, green: 178/255, blue: 115/255).ignoresSafeArea()
                VStack {
                    ProfileHeaderView(user: userData.user)
                   // ProfileWorkoutList()
                    Spacer()
                    LogoutButton(isLoggedIn: $isLoggedIn) // Add LogoutButton
                }
            }
        }
    }
}

//Display the user's username and email in the profile view:
struct ProfileHeaderView: View {
    let user: User?

    var body: some View {
        VStack {
            if let user = user {
                Text(user.userName)
                    .font(.system(size: 24, weight: .bold))
                    .padding(.top, 20)
                Text(user.email)
                    .font(.system(size: 18))
                    .padding(.top, 10)
            } else {
                Text("Loading...")
                    .font(.system(size: 24, weight: .bold))
                    .padding(.top, 20)
            }
        }
    }
}

// Define ProfileWorkoutList
struct ProfileWorkoutList: View {
    @EnvironmentObject var workoutData: WorkoutData

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(workoutData.selectedExercises.keys.sorted(), id: \.self) { key in
                    ProfileDayWorkoutsView(day: key)
                }
            }
            .padding(.horizontal, 20)
            .background(Color.white)
            .cornerRadius(30)
        }
    }
}

// Define ProfileDayWorkoutsView
struct ProfileDayWorkoutsView: View {
    @EnvironmentObject var workoutData: WorkoutData
    let day: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(day)
                .font(.headline)
                .foregroundColor(.black)
            ForEach(workoutData.selectedExercises[day] ?? [], id: \.id) { workout in
                ProfileWorkoutView(workout: workout, day: day)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }
}

// Define ProfileWorkoutView
struct ProfileWorkoutView: View {
    @EnvironmentObject var workoutData: WorkoutData
    let workout: NamedWorkout
    let day: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(workout.name)
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                Button(action: {
                    deleteWorkout()
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
            }
            ForEach(workout.exercises, id: \.self) { exercise in
                Text(exercise)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }

    private func deleteWorkout() {
        // Delete the entire workout for the day
        workoutData.selectedExercises.removeValue(forKey: day)
        workoutData.saveWorkouts()
    }
}

// Define LogoutButton
struct LogoutButton: View {
    @Binding var isLoggedIn: Bool

    var body: some View {
        Button(action: {
            logout()
        }) {
            Text("Log out")
                .foregroundColor(.green)
                .padding()
                .frame(width: 90, height: 40)
                .background(Color.white)
                .cornerRadius(10)
                
        }
    }
//Funktionen använder Firebase Authentication för att logga ut användaren och uppdaterar sedan isLoggedIn-bindingen till false, vilket leder till att användaren skickas tillbaka till inloggningssidan.
    private func logout() {
        do {
            try Auth.auth().signOut() 
            isLoggedIn = false
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

// Define ProfileView_Previews
struct ProfileView_Previews: PreviewProvider {
    @State static var isLoggedIn = true

    static var previews: some View {
        ProfileView(isLoggedIn: $isLoggedIn)
            .environmentObject(WorkoutData())
    }
}
