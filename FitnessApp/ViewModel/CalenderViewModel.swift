//
//  CalenderViewModel.swift
//  TempBuilder
//
//  Created by Abdulrahman.Alazrak on 2024-05-21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase

class CalenderViewModel: ObservableObject{
    //time is saved as frukost, lunch or dinner.
    let db = Firestore.firestore()
    var user: String
    @Published var recepies: [CalenderRecepie] = []
    init(user: String) {
        self.user = user
        db.document("calender/\(user)")//updates the recepies all the time
            .collection("recepies")
            .addSnapshotListener{querySnapshot, error in
                if let error = error{
                    print("error getting recepies in snapshotlistnere: \(error)")
                    return
                }
                var someRecepies: [CalenderRecepie] = []
                if (querySnapshot != nil && !querySnapshot!.documents.isEmpty) {
                    for document in querySnapshot!.documents{
                        let id = document.get("id") as! Int
                        let aDay = document.get("day") as! String
                        let time = document.get("time") as! String
                        let title = document.get("title") as! String
                        let documentID = document.get("documentID") as! String
                        let image = document.get("image") as! String
                        let imageType = document.get("imageType") as! String
                        let aRecepie = CalenderRecepie(anId: id, aTitle: title, aDocumentID: documentID, anImage: image, anImageType: imageType, aDay: aDay, aTime: time)
                        someRecepies.append(aRecepie)
                    }
                } else{
                    print("no data gotting in snapshotlistener")
                }
                self.recepies = someRecepies
            }
    }
    func saveRecipe(day: String, time: String, recepie: ReceptBasic, result: @escaping (Bool) -> ()){
        let randomID = UUID().uuidString
        db.document("calender/\(user)")
            .collection("recepies")
            .document(randomID)
            .setData(recepieToData(recepie: recepie, aDay: day, aTime: time, documentID: randomID)){ error in
                if let error = error{
                    result(false)
                    print("error saving recepie in calender: \(error)")
                    return
                }
                result(true)
            }
            
    }
    func getRecepiesForDay(day: String, result: @escaping ([CalenderRecepie]) -> ()) {
        db.document("calender/\(user)")
            .collection("recepies")
            .getDocuments(completion: { querySnapshot, error in
                if let error = error{
                    print("error getting recepies from calender: \(error)")
                    return
                }
                var someRecepies: [CalenderRecepie] = []
                for document in querySnapshot!.documents{
                    let id = document.get("id") as! Int
                    let aDay = document.get("day") as! String
                    let time = document.get("time") as! String
                    let title = document.get("title") as! String
                    let documentID = document.get("documentID") as! String
                    let image = document.get("image") as! String
                    let imageType = document.get("imageType") as! String
                    if(day == aDay){
                        let aRecepie = CalenderRecepie(anId: id, aTitle: title, aDocumentID: documentID, anImage: image, anImageType: imageType, aDay: aDay, aTime: time)
                        someRecepies.append(aRecepie)
                    }
                }
                result(someRecepies)
            })
    }
    func deleteRecepie(aDocumentID: String){
        db.document("calender/\(user)")
            .collection("recepies")
            .document(aDocumentID)
            .delete(){ error in
                if let error = error{
                    print("error deleting recepies from calender: \(error)")
                    return
                }
                print("succes deleting recepies from calender")
            }
    }
    func getRecepies(result: @escaping ([CalenderRecepie]) -> ()) {
        db.document("calender/\(user)")
            .collection("recepies")
            .getDocuments(completion: { querySnapshot, error in
                if let error = error{
                    print("error getting recepies from calender: \(error)")
                    return
                }
                var someRecepies: [CalenderRecepie] = []
                for document in querySnapshot!.documents{
                    let id = document.get("id") as! Int
                    let aDay = document.get("day") as! String
                    let documentID = document.get("documentID") as! String
                    let time = document.get("time") as! String
                    let title = document.get("title") as! String
                    let image = document.get("image") as! String
                    let imageType = document.get("imageType") as! String
                    let aRecepie = CalenderRecepie(anId: id, aTitle: title, aDocumentID: documentID, anImage: image, anImageType: imageType, aDay: aDay, aTime: time)
                    someRecepies.append(aRecepie)
                }
                result(someRecepies)
            })
    }

    func recepieToData(recepie: ReceptBasic, aDay: String, aTime: String, documentID: String) -> [String: Any]{//so I dont write this code many times for no reason
        return [
            "day" : aDay,
            "time" : aTime,
            "documentID" : documentID,
            "id" : recepie.id,
            "image": recepie.image,
            "title" : recepie.title,
            "imageType" : recepie.imageType
        ]
    }

}
