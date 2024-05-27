import SwiftUI
import FirebaseAuth

struct RegisterPage: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var userIsRegistered = false

    let auto = FireBase()
    let authRef = Auth.auth()

    var body: some View {
        NavigationView {
            ZStack {
                // Background color
                Color(red: 27/255, green: 178/255, blue: 115/255)
                    .ignoresSafeArea() // Extend background color to edges of screen
                
                VStack {
                    Spacer()
                    VStack {
                        // Title
                        Text("Register your account")
                            .font(.system(size: 24, weight: .bold))
                            .padding(.bottom, 10)

                        VStack(spacing: 10) {
                            Group {
                                TextField("Username", text: $username)
                                    .padding()
                                    .background(Color(red: 226/255, green: 234/255, blue: 226/255))
                                    .frame(width: 300, height: 70)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 4.0)
                                            .stroke(Color(red: 27/255, green: 178/255, blue: 115/255), lineWidth: 4)
                                    )

                                TextField("Email", text: $email)
                                    .padding()
                                    .background(Color(red: 226/255, green: 234/255, blue: 226/255))
                                    .cornerRadius(1.0)
                                    .frame(width: 300, height: 70)
                                    .foregroundColor(.secondary)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 1.0)
                                            .stroke(Color(red: 27/255, green: 178/255, blue: 115/255), lineWidth: 4)
                                    )

                                SecureField("Password", text: $password)
                                    .padding()
                                    .background(Color(red: 226/255, green: 234/255, blue: 226/255))
                                    .cornerRadius(1.0)
                                    .frame(width: 300, height: 70)
                                    .foregroundColor(.secondary)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 1.0)
                                            .stroke(Color(red: 27/255, green: 178/255, blue: 115/255), lineWidth: 4)
                                    )

                                SecureField("Confirm Password", text: $confirmPassword)
                                    .padding()
                                    .background(Color(red: 226/255, green: 234/255, blue: 226/255))
                                    .cornerRadius(1.0)
                                    .frame(width: 300, height: 70)
                                    .foregroundColor(.secondary)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 1.0)
                                            .stroke(Color(red: 27/255, green: 178/255, blue: 115/255), lineWidth: 4)
                                    )
                            }
                            .padding(.top, 10)

                            Button(action: {
                                registerUser()
                            }) {
                                Text("SIGN UP")
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(width: 300, height: 70)
                                    .background(Color(red: 27/255, green: 178/255, blue: 115/255))
                                    .cornerRadius(25.0)
                            }
                            .alert(isPresented: $showAlert) {
                                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                            }

                            NavigationLink(destination: LoginPage(isLoggedIn:.constant(false)), isActive: $userIsRegistered) {
                                EmptyView()
                            }
                            .hidden()
                        }
                        .padding(.leading, 20)
                        .padding(.top, 30)
                        
                        HStack {
                            Text("I have an account?")
                            NavigationLink(destination: LoginPage(isLoggedIn:.constant(false))) {
                                Text("Login here")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(red: 27/255, green: 178/255, blue: 115/255))
                            }
                        }
                        .padding(.top, 40)
                        .padding(.bottom, 80)
                    }
                    .frame(width: 390, height: 550)
                    .padding(.top, 50)
                    .background(Color.white)
                    .cornerRadius(30)
                    .background(Color(red: 226/255, green: 234/255, blue: 226/255))
                    .cornerRadius(30)
                }
            }
        }
    }

    func registerUser() {
        if password != confirmPassword {
            showAlert = true
            alertMessage = "Passwords do not match."
            return
        }

        if username.isEmpty || email.isEmpty || password.isEmpty {
            showAlert = true
            alertMessage = "All fields are required."
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                showAlert = true
                alertMessage = "Registration failed: \(error.localizedDescription)"
            } else {
                userIsRegistered = true
            }
        }
    }
}

#Preview {
    RegisterPage()
}
