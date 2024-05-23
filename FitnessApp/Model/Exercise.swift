//
//  Exercise.swift
//  FitnessApp
//
//  Created by Hanad.Ahmed on 2024-05-22.
//

import Foundation
struct Exercise : Decodable {
    let bodyPart: String
    let equipment: String
    let gifUrl: String
    let id: String
    let name: String
    let target: String
    let secondaryMuscles: [String]
    let instructions: [String]
}
