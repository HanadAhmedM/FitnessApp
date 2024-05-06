//
//  AppDelegate.swift
//  FitnessApp
//
//  Created by Elin.Andersson on 2024-05-05.
//
/*Definiera AppDelegate som en bro för att initialisera Firebase vid appens start. Sedan registrerar vi denna AppDelegate i vår SwiftUI App-struct med UIApplicationDelegateAdaptor för att hålla den aktiv tillsammans med SwiftUI lifecycle.*/
import UIKit
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
