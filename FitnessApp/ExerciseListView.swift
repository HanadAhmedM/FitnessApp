import SwiftUI
import Foundation

struct ExercisesListView: View {
    @Binding var selectedExercise: String?
    @Binding var selectedDay: String?
    @State private var bodyParts: [String] = []
    @EnvironmentObject var workoutData: WorkoutData
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            List {
                ForEach(bodyParts, id: \.self) { bodyPart in
                    NavigationLink(destination: ExerciseView(bodyPart: .constant(bodyPart))) {
                        HStack(spacing: 20) {
                            Image(bodyPart)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .background(Color(hex: "E2EAE2"))
                                .cornerRadius(8)
                            
                            Text(bodyPart)
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(Color.black)
                                .frame(maxWidth: .infinity) // Dynamically adjusts width based on content
                            
                            Spacer()
                            
                            if let selectedDay = selectedDay, !selectedDay.isEmpty {
                                Button(action: {
                                    workoutData.addExercise(bodyPart, to: selectedDay, name: bodyPart)
                                 
                                }) {
                                    Image("PlusK")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(Color.blue)
                                        .padding(7)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                 
                }
                .background(Color(hex: "E2EAE2"))
                .padding(.leading,10)
                .frame(width: 330, height: 100,alignment: .center)
                .cornerRadius(10)
            }
            .background(Color(hex: "E2EAE2"))
            .listStyle(PlainListStyle())
            .onAppear {
                fetchData()
            }
        }
    }

    func fetchData() {
        WorkoutAPI().fetchWorkouts { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let bodyParts):
                    self.bodyParts = bodyParts
                case .failure(let error):
                    print("Error fetching data:", error)
                    // Handle error if needed
                }
            }
        }
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}

struct ExercisesListView_Previews: PreviewProvider {
    @State static var selectedDay: String? = ""
    @State static var selectedExercise: String? = ""

    static var previews: some View {
        ExercisesListView(selectedExercise: $selectedExercise, selectedDay: $selectedDay)
            .environmentObject(WorkoutData())
    }
}
