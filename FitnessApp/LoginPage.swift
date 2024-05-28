import SwiftUI
import FirebaseAuth

struct LoginPage: View {
    @Binding var isLoggedIn: Bool
    @EnvironmentObject var userData: UserData
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    let authRef = Auth.auth()
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background colo
                Color(red: 27/255, green: 178/255, blue: 115/255)
                    .ignoresSafeArea()
                
                VStack {
                    
                    Spacer()
                    VStack{
                        
                        
                        // Title
                        Text("Login to your account ")
                        
                            .font(.system(size: 24, weight: .bold))
                            .padding(.bottom,20)
                        
                        VStack(spacing:10) {
                            
                            VStack{
                                Group {
                                    // Email TextField
                                    TextField("Email", text: $email)
                                        .padding()
                                        .background(Color(red: 226/255, green: 234/255, blue: 226/255))
                                    
                                        .frame(width:300,height: 70)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 4.0)
                                                .stroke( Color(red: 27/255, green: 178/255, blue: 115/255), lineWidth: 4)
                                            
                                        )
                                    // Password TextField
                                    SecureField("Password", text: $password)
                                        .padding()
                                    
                                        .background(Color(red: 226/255, green: 234/255, blue: 226/255))
                                        .cornerRadius(1.0)
                                        .frame(width:300,height: 70)
                                        .foregroundColor(.secondary)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 1.0)
                                                .stroke( Color(red: 27/255, green: 178/255, blue: 115/255), lineWidth: 4)
                                        )
                                    Button(action: {
                                        login()
                                    }) {
                                        Text("LOGIN")
                                            .foregroundColor(.white)
                                            .padding()
                                            .frame(width: 300, height: 70)
                                            .background(Color(red: 27/255, green: 178/255, blue: 115/255))
                                            .cornerRadius(25.0)
                                    }
                                    .alert(isPresented: $showAlert) {
                                        Alert(title: Text("Login Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                                    }
                                }
                                .padding(.top, 20)
                            }
                            
                            .padding(.leading, 20)
                            .padding(.top, 30)
                            
                            HStack {
                                Text("Don't have an account?")
                                NavigationLink(destination: RegisterPage()) {
                                    Text("Register here")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color(red: 27/255, green: 178/255, blue: 115/255))
                                }
                            }
                            .padding(.top, 70)
                            .padding(.bottom, 50)
                        }
                        .frame(width: 390, height: 550)
                        .padding(.top, 50)
                        .background(Color.white)
                        .cornerRadius(30)
                        .background(Color(red: 226/255, green: 234/255, blue: 226/255))
                        .cornerRadius(30)
                    }.background(Color(hex: "F2F2F2"))
                    
                    
                    
                }
                
            }
            
        }.ignoresSafeArea() // Extend background color to edges of screen
    }
    
    func login() {
        if password.isEmpty || email.isEmpty {
            showAlert = true
            alertMessage = "Username and Password cannot be empty."
        } else {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    showAlert = true
                    alertMessage = "Login failed. Please check your credentials."
                } else {
                    // isLoggedIn = true
                    //After a successful login, fetch the user data and update the UserData environment object:
                    if let userId = Auth.auth().currentUser?.uid {
                        // Fetch user data
                        FireBase().fetchUser(userId: userId) { user in
                            if let user = user {
                                // Update the environment object
                                userData.user = user 
                                isLoggedIn = true
                            } else {
                                showAlert = true
                                alertMessage = "Failed to fetch user data."
                            }
                        }
                    }
                }
            }
        }
    }
}


struct LoginPage_Previews: PreviewProvider {
    @State static var isLoggedIn = false
    
    static var previews: some View {
        LoginPage(isLoggedIn: $isLoggedIn)
            .environmentObject(UserData())
    }
}
