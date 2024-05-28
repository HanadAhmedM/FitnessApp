//
//  SearchViewModel.swift
//  FitnessApp
//
//  Created by Abdulrahman.Alazrak on 2024-05-08.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase

class SearchViewModel: ObservableObject{
    
    let db = Firestore.firestore()
    // Published property to hold an array of ReceptBasic objects
    @Published var currentRecepies: [ReceptBasic] = []
    // Published property to hold a single ReceptFull object
    @Published var currentRecepie: ReceptFull = ReceptFull()
    
    @Published var changer: String = "" //a text to change so that the view gets updated
    
    // Method to fetch recipes based on provided parameters
    func getRecepies(theItems: [String: String]){
        FoodApiService.shared.getRecepies(someItems: theItems, completion: { recepies in
            self.currentRecepies = recepies
        })
    }
    
    // Method to fetch a single recipe by its ID
    func getRecepie(theId: Int){
        FoodApiService.shared.getRecepie(id: theId, completion: { recepie in
            DispatchQueue.main.async {
                print("recepie from Api title: \(recepie.title)")
                self.currentRecepie = recepie
                self.currentRecepie.title = recepie.title
                print("changer in vm: \(self.changer), title: \(self.currentRecepie.title)")
                DispatchQueue.main.asyncAfter(deadline: .now() + 5){//p.ga syncnings problem behövde jag
                    self.changer = "uIUpdgggate"
                    self.currentRecepie.title = recepie.title
                    print("changer in vm after: \(self.changer), title: \(self.currentRecepie.title)")
                }
            }
        })
    }
    
    // Method to fetch a single recipe synchronously by its ID
    func getRecepieInCode(theId: Int, resultRecepie: @escaping (ReceptFull) -> ()){
        FoodApiService.shared.getRecepie(id: theId, completion: { recepie in
            resultRecepie(recepie)
        })
    }
    func recepieToData(recepie: ReceptBasic) -> [String: Any]{
        return [
            "id" : recepie.id,
            "image": recepie.image,
            "title" : recepie.title,
            "imageType" : recepie.imageType
        ]
    }
    func makeImage100x100(image: String, imageType: String) -> String{
        let parts = image.components(separatedBy: "-")
        return parts[0] + "-90x90." + imageType
    }
}
