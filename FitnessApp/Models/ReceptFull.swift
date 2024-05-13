//
//  ReceptFull.swift
//  FitnessApp
//
//  Created by Abdulrahman.Alazrak on 2024-05-06.
//

import Foundation
class Ingredient: ObservableObject{
    @Published var id: Int = 0 // Unique identifier
    @Published var name: String = "" // Name of the ingredient
    @Published var localizedName: String = "" // Localized name of the ingredient
    @Published var image: String = "" // Image URL representing the ingredient
    
    init(){
        
    }
    init(id: Int, name: String, localizedName: String, image: String) {
        self.id = id
        self.name = name
        self.localizedName = localizedName
        self.image = image
    }
}

// Struct representing equipment used in a recipe
class Equipment: ObservableObject{
    @Published var id: Int = 0
    @Published var name: String = ""
    @Published var localizedName: String = ""
    @Published var image: String = ""
    
    init(){
        
    }
    init(id: Int, name: String, localizedName: String, image: String) {
        self.id = id
        self.name = name
        self.localizedName = localizedName
        self.image = image
    }
}

// Struct representing a step in the recipe preparation process
class Step: ObservableObject{
    @Published var number: Int = 0
    @Published var step: String = ""
    @Published var ingredients: [Ingredient] = []
    @Published var equipment: [Equipment] = []
    
    init(){
        
    }
    init(number: Int, step: String, ingredients: [Ingredient], equipment: [Equipment]) {
        self.number = number
        self.step = step
        self.ingredients = ingredients
        self.equipment = equipment
    }
}

// Struct representing an analyzed instruction for preparing a recipe
class AnalyzedInstruction: ObservableObject{
    @Published var name: String = ""
    @Published var steps: [Step] = []
    
    init(){
        
    }
    init(name: String, steps: [Step]) {
        self.name = name
        self.steps = steps
    }
}

// Struct representing a full recipe
class ReceptFull: ObservableObject{
    @Published var id: Int = 0
    @Published var title: String = ""
    @Published var image: String = ""
    @Published var imageType: String = ""
    @Published var servings: Int = 0
    @Published var preparationMinutes: Int = 0
    @Published var cookingMinutes: Int = 0
    @Published var aggregateLikes: Int = 0
    @Published var readyInMinutes: Int = 0
    @Published var license: String = ""
    @Published var sourceName: String = ""
    @Published var sourceUrl: String = ""
    @Published var spoonacularSourceUrl: String = ""
    @Published var healthScore: Double = 0.0
    @Published var spoonacularScore: Double = 0.0
    @Published var pricePerServing: Double = 0.0
    @Published var analyzedInstructions: [AnalyzedInstruction] = []
    @Published var cheap: Bool = false
    @Published var creditsText: String = ""
    @Published var cuisines: [String] = []
    @Published var dairyFree: Bool = false
    @Published var diets: [String] = []
    @Published var gaps: String = ""
    @Published var glutenFree: Bool = false
    @Published var instructions: String = ""
    @Published var ketogenic: Bool = false
    @Published var lowFodmap: Bool = false
    @Published var occasions: [String] = []
    @Published var sustainble: Bool = false
    @Published var vegetarian: Bool = false
    @Published var vegan: Bool = false
    @Published var veryHealthy: Bool = false
    @Published var veryPopular: Bool = false
    @Published var whole30: Bool = false
    @Published var weightWatcherSmartPoints: Int = 0
    @Published var dishTypes: [String] = []
    @Published var extendedIngredients: [extendedIngredient] = []
    @Published var summary: String = ""
    
}

// Struct representing an extended ingredient used in a recipe
class extendedIngredient: ObservableObject{
    @Published var aisle: String = ""
    @Published var amount: Double = 0.0
    @Published var consistency: String = ""
    @Published var image: String = ""
    @Published var id: Int = 0
    @Published var name: String = ""
    @Published var nameClean: String = ""
    @Published var original: String = ""
    @Published var originalName: String = ""
    @Published var unit: String = ""
    @Published var meta: [String] = []
    @Published var measures: Measures?
    
    init(){
        
    }
    init(aisle: String, amount: Double, consistency: String, image: String, id: Int, name: String, nameClean: String, original: String, originalName: String, unit: String, meta: [String], measures: Measures? = nil) {
        self.aisle = aisle
        self.amount = amount
        self.consistency = consistency
        self.image = image
        self.id = id
        self.name = name
        self.nameClean = nameClean
        self.original = original
        self.originalName = originalName
        self.unit = unit
        self.meta = meta
        self.measures = measures
    }
}


// Struct representing measures for an ingredient
class Measures: ObservableObject{
    @Published var us: Measure = Measure()
    @Published var metric: Measure = Measure()
    
    init(){
        
    }
    init(us: Measure, metric: Measure) {
        self.us = us
        self.metric = metric
    }
}

// Struct representing a measure for an ingredient
class Measure: ObservableObject{
    @Published var amount: Double = 0.0
    @Published var unitShort: String = ""
    @Published var unitLong: String = ""
    init(){
        
    }
    init(amount: Double, unitShort: String, unitLong: String) {
        self.amount = amount
        self.unitShort = unitShort
        self.unitLong = unitLong
    }
}
