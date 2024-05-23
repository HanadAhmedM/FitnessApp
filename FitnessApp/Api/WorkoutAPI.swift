//
//  WorkoutAPI.swift
//  FitnessApp
//
//  Created by Hanad.Ahmed on 2024-05-22.
//

import Foundation

struct ExerciseResponse: Decodable {
    let Exercises: [Exercise]
}
class WorkoutAPI{
    let headers = [
        "X-RapidAPI-Key": "22bb5784ccmshac21d461dd4f437p11e2c9jsnd1c3762b1be4",
        "X-RapidAPI-Host": "exercisedb.p.rapidapi.com"
    ]
    func fetchWorkouts(completion: @escaping (Result<[String], Error>) -> Void) {
       
            
        guard let url = URL(string: "https://exercisedb.p.rapidapi.com/exercises/bodyPartList") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
                completion(.failure(error))
                return
            }
            
            print("HTTP Status Code:", httpResponse.statusCode)
            
            if !(200...299).contains(httpResponse.statusCode) {
                let error = NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Server error"])
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
                return
            }
            
            do {
                let bodyParts = try JSONDecoder().decode([String].self, from: data)
                completion(.success(bodyParts))
            } catch {
                completion(.failure(error))
            }
        }
        
        dataTask.resume()
    }
    
    func fetchExercises(for bodyPart: String, completion: @escaping (Result<[Exercise], Error>) -> Void) {
          
           
           let urlString = "https://exercisedb.p.rapidapi.com/exercises/bodyPart/\(bodyPart)?limit=10"
           guard let url = URL(string: urlString) else {
               print("Invalid URL")
               completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
               return
           }
           
           var request = URLRequest(url: url)
           request.httpMethod = "GET"
           request.allHTTPHeaderFields = headers
           
           let session = URLSession.shared
           let dataTask = session.dataTask(with: request) { (data, response, error) in
               if let error = error {
                   print("Error:", error)
                   completion(.failure(error))
               } else if let httpResponse = response as? HTTPURLResponse {
                   print("HTTP Status Code:", httpResponse.statusCode)
                   guard (200...299).contains(httpResponse.statusCode) else {
                       let error = NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Server error"])
                       completion(.failure(error))
                       return
                   }
                   
                   guard let data = data else {
                       let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                       completion(.failure(error))
                       return
                   }
                   
                   do {
                       let workouts = try JSONDecoder().decode([Exercise].self, from: data)
                       completion(.success(workouts))
                   } catch {
                       print("Error decoding data:", error)
                       completion(.failure(error))
                   }
               }
           }
           
           dataTask.resume()
       }
   }
