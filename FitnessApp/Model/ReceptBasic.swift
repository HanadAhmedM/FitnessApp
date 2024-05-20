//
//  ReceptBasic.swift
//  FitnessApp
//
//  Created by Abdulrahman.Alazrak on 2024-05-06.
//

import Foundation
class ReceptBasic: Codable, Identifiable{
    var id: Int
    var title: String
    var image: String
    var imageType: String
    init(anId: Int, aTitle: String, anImage: String, anImageType: String){
        id = anId
        title = aTitle
        image = anImage
        imageType = anImageType
    }
}
