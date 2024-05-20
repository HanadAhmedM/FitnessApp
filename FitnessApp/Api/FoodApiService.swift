//
//  FoodApiSercive.swift
//  FitnessApp
//
//  Created by Abdulrahman.Alazrak on 2024-05-06.
//

import Foundation

class FoodApiService{
    // Singleton instance
    static let shared = FoodApiService()
    //Api Keys
    //600587a1ca9e4a99ae2b58baee5958b5         Abdulrahman. Använd den fritt :)
    //38d1af21ef59455da6cab677116a2c35         Abdulrahman. Använd den fritt :)
    //8abf48eb28ad4c33b5749b723e87acd5         Hanad
    let apiKey = "600587a1ca9e4a99ae2b58baee5958b5"
    let baseUrl = "https://api.spoonacular.com"
    //https://api.spoonacular.com/recipes/complexSearch?apiKey=600587a1ca9e4a99ae2b58baee5958b5
    // URLSession for network requests
    let session = URLSession.shared
    
    // Method to fetch recipes based on provided parameters
    func getRecepies(someItems: [String: String], completion: @escaping ([ReceptBasic]) -> () ){
        let urlToUse = baseUrl + "/recipes/complexSearch?apiKey=" + apiKey
        let task = session.dataTask(with: URL(string: appendQueryItems(items: someItems, aUrl: urlToUse))!){data, response, error in
            if let error = error {
                print("error \(error.localizedDescription)")
            }
            guard data != nil else {
                print("no data")
                return
            }
            do{
                completion(self.exrtactReceptBasic(data: data!))
            }
//            catch{
//                print(":(")
//            }
        }
        task.resume()

    }
    
    // Method to extract basic recipe information from JSON data
    func exrtactReceptBasic(data: Data) -> [ReceptBasic]{
        if let jsonDictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
            if let resultsData = try? JSONSerialization.data(withJSONObject: jsonDictionary["results"]!, options: []){
                let decodedData = try? JSONDecoder().decode([ReceptBasic].self, from: resultsData)
                return decodedData!
            }
        }
        return[]
    }
    
    // Method to fetch a specific recipe by its ID
    func getRecepie(id: Int, completion: @escaping (ReceptFull) -> ()){
        let urlToUse = "\(baseUrl)/recipes/\(id)/information?apiKey=\(apiKey)&includeNutrition=false"
        let task = session.dataTask(with: URL(string: urlToUse)!){data, response, error in
            if let error = error {
                print("error \(error.localizedDescription)")
            }
            guard data != nil else {
                print("no data")
                return
            }
            do{
                completion(self.extractReceptFull(data: data!))

            }
//            catch{
//                print(":(")
//            }
        }
        task.resume()
    
    }
    
    // Method to extract detailed recipe information from JSON data
    func extractReceptFull(data: Data) -> ReceptFull{
        var receptFull = ReceptFull()
        if let jsonDictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
            if let ingredients = jsonDictionary["extendedIngredients"] as? [[String: Any]]{//extendedIngredient
                for ingredient in ingredients{
                    var extendedIngredient = extendedIngredient()
                    extendedIngredient.aisle = ingredient["aisle"] as? String ?? ""
                    extendedIngredient.amount = ingredient["amount"] as? Double ?? 0.0
                    extendedIngredient.consistency = ingredient["consistency"] as? String ?? ""
                    extendedIngredient.name = ingredient["name"] as? String ?? ""
                    extendedIngredient.nameClean = ingredient["nameClean"] as? String ?? ""
                    extendedIngredient.original = ingredient["original"] as? String ?? ""
                    extendedIngredient.originalName = ingredient["originalName"] as? String ?? ""
                    extendedIngredient.unit = ingredient["name"] as? String ?? ""
                    extendedIngredient.meta = ingredient["meta"] as? [String] ?? []
                    extendedIngredient.image = ingredient["image"] as? String ?? ""
                    extendedIngredient.id = ingredient["id"] as? Int ?? 0
                    if let measures = ingredient["measures"] as? [String: Any]{
                        var theMeasures = Measures()
                        var theUs = Measure()
                        var theMetric = Measure()
                        if let us = measures["us"] as? [String: Any]{
                            theUs.amount = us["amount"] as? Double ?? 0.0
                            theUs.unitShort = us["unitShort"] as? String ?? ""
                            theUs.unitLong = us["unitLong"] as? String ?? ""
                            theMeasures.us = theUs
                        }
                        if let metric = measures["metric"] as? [String: Any]{
                            theMetric.amount = metric["amount"] as? Double ?? 0.0
                            theMetric.unitShort = metric["unitShort"] as? String ?? ""
                            theMetric.unitLong = metric["unitLong"] as? String ?? ""
                            theMeasures.metric = theMetric
                        }
                        extendedIngredient.measures = theMeasures
                    }
                    receptFull.extendedIngredients.append(extendedIngredient)
                }
            }
            if let analyzedInstructions = jsonDictionary["analyzedInstructions"] as? [[String: Any]]{//getting the instructions
                var theAnalyzedInstructions: [AnalyzedInstruction] = []
                for analyzedInstruction in analyzedInstructions {
                    var theAnalyzedInstruction = AnalyzedInstruction()
                    theAnalyzedInstruction.name = analyzedInstruction["name"] as? String ?? ""
                    if let steps = analyzedInstruction["steps"] as? [[String: Any]]{//getting the steps of a single Instruction
                        var theSteps: [Step] = []
                        for step in steps {
                            var theStep: Step = Step()
                            theStep.number = step["number"] as? Int ?? 0
                            theStep.step = step["step"] as? String ?? ""
                            if let ingredients = step["ingredients"] as? [[String: Any]]{//getting the ingredients of a single step
                                var theIngredients: [Ingredient] = []
                                for ingredient in ingredients {
                                    var theIngredient = Ingredient()
                                    theIngredient.id = ingredient["id"] as? Int ?? 0
                                    theIngredient.name = ingredient["name"] as? String ?? ""
                                    theIngredient.localizedName = ingredient["localizedName"] as? String ?? ""
                                    theIngredient.image = ingredient["image"] as? String ?? ""
                                    theIngredients.append(theIngredient)
                                }
                                theStep.ingredients = theIngredients
                            }
                            if let equipment = step["equipment"] as? [[String: Any]]{//getting the equipment of a single step
                                var theEquipment: [Equipment] = []
                                for oneEquipment in equipment {
                                    var theOneEquipment = Equipment()
                                    theOneEquipment.id = oneEquipment["id"] as? Int ?? 0
                                    theOneEquipment.name = oneEquipment["name"] as? String ?? ""
                                    theOneEquipment.localizedName = oneEquipment["localizedName"] as? String ?? ""
                                    theOneEquipment.image = oneEquipment["image"] as? String ?? ""
                                    theEquipment.append(theOneEquipment)
                                }
                                theStep.equipment = theEquipment
                            }
                            theSteps.append(theStep)
                        }
                        theAnalyzedInstruction.steps = theSteps
                    }
                    theAnalyzedInstructions.append(theAnalyzedInstruction)
                }
                receptFull.analyzedInstructions = theAnalyzedInstructions
            }
            //the rest of the recept
            receptFull.id = jsonDictionary["id"] as? Int ?? -1
            receptFull.title = jsonDictionary["title"] as? String ?? ""
            receptFull.readyInMinutes = jsonDictionary["readyInMinutes"] as? Int ?? 0
            receptFull.servings = jsonDictionary["servings"] as? Int ?? 0
            receptFull.sourceUrl = jsonDictionary["sourceUrl"] as? String ?? ""
            receptFull.image = jsonDictionary["image"] as? String ?? ""
            receptFull.imageType = jsonDictionary["imageType"] as? String ?? ""
            receptFull.summary = jsonDictionary["summary"] as? String ?? ""
            receptFull.cuisines = jsonDictionary["cuisines"] as? [String] ?? []
            receptFull.dishTypes = jsonDictionary["dishTypes"] as? [String] ?? []
            receptFull.diets = jsonDictionary["diets"] as? [String] ?? []
            receptFull.occasions = jsonDictionary["occasions"] as? [String] ?? []
            receptFull.instructions = jsonDictionary["instructions"] as? String ?? ""
            receptFull.spoonacularScore = jsonDictionary["spoonacularScore"] as? Double ?? 0.0
            receptFull.spoonacularSourceUrl = jsonDictionary["spoonacularSourceUrl"] as? String ?? ""
            receptFull.vegetarian = jsonDictionary["vegetarian"] as? Bool ?? false
            receptFull.vegan = jsonDictionary["vegan"] as? Bool ?? false
            receptFull.glutenFree = jsonDictionary["glutenFree"] as? Bool ?? false
            receptFull.dairyFree = jsonDictionary["dairyFree"] as? Bool ?? false
            receptFull.veryHealthy = jsonDictionary["veryHealthy"] as? Bool ?? false
            receptFull.cheap = jsonDictionary["cheap"] as? Bool ?? false
            receptFull.veryPopular = jsonDictionary["veryPopular"] as? Bool ?? false
            receptFull.sustainble = jsonDictionary["sustainble"] as? Bool ?? false
            receptFull.lowFodmap = jsonDictionary["lowFodmap"] as? Bool ?? false
            receptFull.weightWatcherSmartPoints = jsonDictionary["weightWatcherSmartPoints"] as? Int ?? 0
            receptFull.preparationMinutes = jsonDictionary["preparationMinutes"] as? Int ?? 0
            receptFull.cookingMinutes = jsonDictionary["cookingMinutes"] as? Int ?? 0
            receptFull.aggregateLikes = jsonDictionary["aggregateLikes"] as? Int ?? 0
            receptFull.healthScore = jsonDictionary["servings"] as? Double ?? 0.0
            receptFull.pricePerServing = jsonDictionary["pricePerServing"] as? Double ?? 0.0
            receptFull.creditsText = jsonDictionary["creditsText"] as? String ?? ""
            receptFull.summary = jsonDictionary["summary"] as? String ?? ""
        }
        return receptFull
    }
    
    // Method to append query items to a URL string
    public func appendQueryItems(items: [String: String], aUrl: String) -> String{
        var aString = aUrl
        for item in items {
            aString.append("&" + item.key + "=" + item.value)
        }
        return aString
    }

}
