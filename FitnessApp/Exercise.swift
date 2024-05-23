//
//  Exercise.swift
//  FitnessApp
//
//  Created by Hanad.Ahmed on 2024-05-22.
//

import Foundation
struct Exercise: Identifiable, Codable {
    let id: String
    let bodyPart: String
      let equipment: String
      let gifUrl: String
   
      let name: String
      let target: String
      let secondaryMuscles: [String]
      let instructions: [String]
}
