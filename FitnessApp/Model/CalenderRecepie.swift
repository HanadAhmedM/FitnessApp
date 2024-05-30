//
//  CalenderRecepie.swift
//  TempBuilder
//
//  Created by Abdulrahman.Alazrak on 2024-05-27.
//

import Foundation

class CalenderRecepie: ObservableObject, Identifiable{
    @Published var id: Int
    @Published var title: String
    @Published var documentID: String
    @Published var image: String
    @Published var imageType: String
    @Published var day: String
    @Published var time: String
    init(anId: Int, aTitle: String, aDocumentID: String,anImage: String, anImageType: String, aDay: String, aTime: String){
        id = anId
        title = aTitle
        documentID = aDocumentID
        image = anImage
        imageType = anImageType
        day = aDay
        time = aTime
    }
}
