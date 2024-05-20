//
//  RecipeViewModel.swift
//  TempBuilder
//
//  Created by Abdulrahman.Alazrak on 2024-05-16.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase


class RecepieViewModel: ObservableObject{
    let db = Firestore.firestore()
    
    func recepieToData(recepie: ReceptBasic) -> [String: Any]{//so I dont write this code many times for no reason
        return [
            "id" : recepie.id,
            "image": recepie.image,
            "title" : recepie.title,
            "imageType" : recepie.imageType
        ]
    }
    func getLists(result: @escaping ([String]) -> ()){//gets the lists
        db.collection("recepies").getDocuments(completion: { querySnapshot, error in
            if let error = error{
                print("error getting lists: \(error)")
                return
            }
            var tempLists: [String] = []
            for document in querySnapshot!.documents{
                let listName = document.get("listName") as! String
                tempLists.append(listName)
                print(listName)
            }
            result(tempLists)
        })
    }
    func addList(listToAdd: String, result: @escaping (Bool) -> ()){//adds a list
        db.document("recepies/\(listToAdd)")
            .setData(["listName" : listToAdd]){error in//this gets used later when getting the lists
                if let error = error{
                    print("Error adding list: \(error)")
                    result(false)
                    return
                }
                result(true)
                print("success adding list")
            }
    }
    func getListRecepies(listName: String, result: @escaping ([ReceptBasic]) -> ()){// gets the recepies in a list
        db.document("recepies/\(listName)")
            .collection("theRecepies")
            .getDocuments(completion: { querySnapshot, error in
                if let error = error{
                    print("Error getting recepies: \(error)")
                    return
                }
                var recepies: [ReceptBasic] = []
                for document in querySnapshot!.documents{
                    let id = document.get("id") as! Int
                    let title = document.get("title") as! String
                    let image = document.get("image") as! String
                    let imageType = document.get("imageType") as! String
                    let recepie = ReceptBasic(anId: id, aTitle: title, anImage: image, anImageType: imageType)
                    recepies.append(recepie)
                }
                result(recepies)
            })
    }
    func makeImage90x90(image: String, imageType: String) -> String{//makes a spoonaculare image url give a 90x90 image
        let parts = image.components(separatedBy: "-")
        return parts[0] + "-90x90." + imageType
    }
    func saveRecepieTo(list: String, recepie: ReceptBasic, result: @escaping (Bool) -> ()){//saves a recipe to a list
        db.document("recepies/\(list)")
            .collection("theRecepies")
            .document(String(recepie.id))//by having the recipe id as document id, one avoids many copies of the same recipe
            .setData(recepieToData(recepie: recepie)){error in
                if let error = error{
                    result(false)
                    print("Error adding recepie to list: \(error)")
                    return
                }
                result(true)
                print("success adding recepie to list")

            }
    }
}
