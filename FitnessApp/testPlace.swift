//
//  testPlace.swift
//  FitnessApp
//
//  Created by Abdulrahman.Alazrak on 2024-05-06.
//

import SwiftUI

struct testPlace: View {
    var api = FoodApiService()
    var vm = SearchViewModel()

    @State var recept: [ReceptBasic] = []
    var body: some View {
        Button("click me", action: {
            var temp = vm.makeImage100x100(image: "https://img.spoonacular.com/recipes/579247-556x370.jpg", imageType: "jpg")
            print(temp)
        })
        List(recept){ rece in
            Text(rece.title)
        }
    }
}

#Preview {
    testPlace()
}
