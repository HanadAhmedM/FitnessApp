//
//  RegisterPage.swift
//  FitnessApp
//
//  Created by Hanad.Ahmed on 2024-05-06.
//

import SwiftUI

struct RegisterPage: View {
    // State variables to store username, email, password, and confirm password
    @State private var username: String = ""
    @State private var email: String=""
       @State private var password: String = ""
    @State private var confirmPassword: String = ""
  
       let auto = FireBase()
    @State private var showAlert = false
      @State private var alertMessage = ""
        
    var body: some View {
        NavigationView{
            ZStack {
                // Background colo
                Color(red: 27/255, green: 178/255, blue: 115/255)
                       
               
                       VStack {
                           Spacer()
                           VStack{
                               // Title
                               Text("Create New Account  ")
                    
                                   .font(.system(size: 24, weight: .bold))
                                   .padding(.bottom,30)
                                   
                               VStack(spacing:10) {
                            
                                   VStack{
                                       Group {
                                           // Username TextField
                                           TextField("Username", text: $username)
                                               .padding()
                                               .background(Color(red: 226/255, green: 234/255, blue: 226/255))
                                               
                                               .frame(width:300,height: 70)
                                               .overlay(
                                                                         RoundedRectangle(cornerRadius: 4.0)
                                                                            .stroke( Color(red: 27/255, green: 178/255, blue: 115/255), lineWidth: 4)
                                                                            
                                               )
                                           // Email TextField
                                           TextField("Email", text: $email)
                                               .padding()
                                               .background(Color(red: 226/255, green: 234/255, blue: 226/255))
                                               .cornerRadius(1.0)
                                               .frame(width:300,height: 70)
                                               .foregroundColor(.secondary)
                                               .overlay(
                                                                         RoundedRectangle(cornerRadius: 1.0)
                                                                            .stroke( Color(red: 27/255, green: 178/255, blue: 115/255), lineWidth: 4)
                                           )
                                           
                                           // Password TextField
                                           TextField("Password", text: $password)
                                               .padding()
                                               .background(Color(red: 226/255, green: 234/255, blue: 226/255))
                                               .cornerRadius(1.0)
                                               .frame(width:300,height: 70)
                                               .foregroundColor(.secondary)
                                               .overlay(
                                                                         RoundedRectangle(cornerRadius: 1.0)
                                                                            .stroke( Color(red: 27/255, green: 178/255, blue: 115/255), lineWidth: 4)
                                           )
                                           
                                           // Conform Password TextField
                                           TextField("Conform Password", text: $confirmPassword)
                                               .padding()
                                               .background(Color(red: 226/255, green: 234/255, blue: 226/255))
                                               .cornerRadius(1.0)
                                               .frame(width:300,height: 70)
                                               .foregroundColor(.secondary)
                                               .overlay(
                                                                         RoundedRectangle(cornerRadius: 1.0)
                                                                            .stroke( Color(red: 27/255, green: 178/255, blue: 115/255), lineWidth: 4)
                                           )
                                           // SIGN UP Button
                                           Button(action: { 
                                               
                                               // Check if passwords match
                                               if password != confirmPassword{
                                                   Button(action: {
                                                       // Show an alert
                                                                              self.showAlert = true
                                                                              self.alertMessage = "Passwords need to match"
                                                   }){
                                                       EmptyView()
                                                   }
                                                   .alert(isPresented: $showAlert) {
                                                                           Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                                                                       }
                                                   .hidden() // Hide the button, it's just for triggering the alert
                                               } else {
                                                   auto.register( username: username , email: email, password: password)
                                               }
                                               
                                           
                                            
                                           }) {
                                               Text("SIGN UP")
                                                   .foregroundColor(.white)
                                                   .padding(.top,10)
                                                   .frame(width:300,height: 70)
                                                   .background( Color(red: 27/255, green: 178/255, blue: 115/255))
                                                   .cornerRadius(25.0)
                                           }
                                       }.padding(.top, 20)
                                           
                                   }.padding(.leading,20)
                                       .padding(.top,20)
                                  
                                   HStack{
                                       Text("I have an account?")
                                       NavigationLink(destination: LoginPage()){
                                           Text("Login here")
                                                             .font(.system(size: 14))
                                                             .foregroundColor( Color(red: 27/255, green: 178/255, blue: 115/255))
                                       }
                                      
                                                         
                                   }
                                   .padding(.top,40)
                                   
                                   .padding(.bottom,80)
            
                            
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
    
       }
#Preview {
    RegisterPage()
}
