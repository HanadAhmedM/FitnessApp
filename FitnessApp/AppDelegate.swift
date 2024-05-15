//
//  AppDelegate.swift
//  FitnessApp
//
//  Created by Hanad.Ahmed on 2024-05-15.
//

import Foundation
import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
     
    return true
  }
}
