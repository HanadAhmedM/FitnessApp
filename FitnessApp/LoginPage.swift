//
//  LoginPage.swift
//  FitnessApp
//
//  Created by Hanad.Ahmed on 2024-05-02.
//

import SwiftUI
import FirebaseAuth

struct LoginPage: View {
    // State variables to store username and password
       @State private var email: String = ""
       @State private var password: String = ""
       @State private var showAlert = false
       @State private var alertMessage = ""
       @State  var userIsRegistered = false
       var auto = FireBase()
       let authRef = Auth.auth()
       var body: some View {
           NavigationView {
               ZStack {
                   // Background colo
                   Color(red: 27/255, green: 178/255, blue: 115/255)
                   
                   
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
                                       // Login Button
                                       Button(action: {
                                           login()
                                       }) {
                                           Text("LOGIN")
                                               .foregroundColor(.white)
                                               .padding(.top,10)
                                               .frame(width:300,height: 70)
                                               .background( Color(red: 27/255, green: 178/255, blue: 115/255))
                                               .cornerRadius(25.0)
                                       }
                                       .alert(isPresented: $showAlert) {
                                           Alert(title: Text("Login Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                                       }
                                       // This NavigationLink is used to navigate to 
                                       NavigationLink(destination: PlanView(), isActive: $userIsRegistered) {
                                           EmptyView()
                                       }
                                       .hidden()
                                   }.padding(.top, 20)
                                   
                               }.padding(.leading,20)
                                   .padding(.top,30)
                               HStack{
                                   Text("Dont have an account?")
                                   NavigationLink(destination: RegisterPage()){
                                       Text("Register here")
                                           .font(.system(size: 14))
                                           .foregroundColor( Color(red: 27/255, green: 178/255, blue: 115/255))
                                   }
                                   
                                   
                                   
                               }
                               .padding(.top,70)
                               
                               .padding(.bottom,50)
                               
                               
                           }
                           
                           .frame(width:390,height: 550)
                           .padding(.top,50)
                           .background(.white)
                       }
                       .background(Color(red: 226/255, green: 234/255, blue: 226/255))
                       .cornerRadius(30)
                   }
                   
                   
                   .ignoresSafeArea() // Extend background color to edges of screen
                   
               }
               .ignoresSafeArea() // Extend background color to edges of screen
           }
       }
       func login() {
           if password.isEmpty || email.isEmpty {
               showAlert = true
               alertMessage = "Username and Password cannot be empty."
           } else {
               // Call Firebase authentication method
               auto.loginUser(email: email, password: password) { success, error in
                   if success {
                       // Navigate to the content view
                       userIsRegistered = true
                   } else {
                       showAlert = true
                       alertMessage = "Login failed. Please check your credentials."
                   }
               }
           }
       }
           
           
      
       
       
   }

#Preview {
    LoginPage()
}
