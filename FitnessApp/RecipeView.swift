//
//  RecipeView.swift
//  ReceptProject
//
//  Created by Hanad.Ahmed on 2024-03-05.
//

//
//  RecipeView.swift
//  ReceptProject
//
//  Created by Hanad.Ahmed on 2024-03-05.
//
import WebKit
import SwiftUI

struct RecipeView: View {
    @ObservedObject var vm: SearchViewModel
    @ObservedObject var aRecepie = ReceptFull()
    @State var aChanger = ""
    var body: some View {
        ZStack{
            Color(red: 27/255, green: 178/255, blue: 115/255)
            Text(vm.changer)//just a text that changes a little bit after the the recept is gotten to update the view
                .foregroundStyle(.clear)
            Text(aChanger)//just a text that changes a little bit after the the recept is gotten to update the view
                .foregroundStyle(.clear)
            VStack{
                Text(vm.currentRecepie.title)
                    .multilineTextAlignment(.leading)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.top, 70)
                
                ScrollView(showsIndicators: false){
                    VStack{
                        AsyncImage(url: URL(string: vm.currentRecepie.image))
                            .padding(.top, 50)
                        HStack{
                            VStack{
                                Image(systemName: "dollarsign.circle.fill")
                                    .foregroundStyle(.orange)
                                Text("$\(twoDeci(double: vm.currentRecepie.pricePerServing))")
                            }
                            VStack{
                                Image(systemName: "heart.fill")
                                    .foregroundStyle(.red)
                                Text("\(vm.currentRecepie.aggregateLikes) likes")
                            }
                            VStack{
                                Image(systemName: "clock.fill")
                                    .foregroundStyle(.purple)
                                Text("ready in \(vm.currentRecepie.readyInMinutes)")
                            }
                            VStack{
                                Image(systemName: "speedometer")
                                    .foregroundStyle(.yellow)
                                Text("spoonacular \nScore: \(twoDeci(double: vm.currentRecepie.spoonacularScore))")
                            }
                        }
                        Text(htmlToPlainText(htmlString: vm.currentRecepie.summary))
                            .padding(8)
                            .background(Color(hue: 0.33, saturation: 0.16, brightness: 0.90))
                            .cornerRadius(20)
                            .padding(8)
                        IngredientsView(ingredients: vm.currentRecepie.extendedIngredients)
                        Text(htmlToPlainText(htmlString: vm.currentRecepie.instructions))
                            .padding(8)
                            .background(Color(hue: 0.33, saturation: 0.16, brightness: 0.90))
                            .cornerRadius(20)
                            .padding(8)
                        Spacer()
                            .frame(height: 100)
                    }
                    .frame(width: 393)
                    .background(.white)
                    .cornerRadius(20)
                }
                .padding(.top, 20)
            }
            .frame(width: 393)
            Text(vm.changer)//just a text that changes a little bit after the the recept is gotten to update the view
        }
        .ignoresSafeArea()
        
    }
    func twoDeci(double: Double) -> String{// because the doubles in recept had too many
        return String(format: "%.2f", double)
    }
    func htmlToPlainText(htmlString: String) -> String {//From the internet, quick fix to that summary and instructions are Html text(I think) so they had charachters like: <> in the text. With this the charachters go away but no effect of these charachters are acheived for some reason. like making som part of the text bold
        guard let data = htmlString.data(using: .utf8) else {
            return htmlString
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return htmlString
        }
        
        return attributedString.string
    }
}
struct IngredientsView: View {
    @State var showIng = false//variablen som bästemmer om ingrediencerna ska visas eller inte
    var ingredients: [extendedIngredient]
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Text("Ingredients")
                Image(systemName: showIng ? "chevron.up" : "chevron.down")
                Spacer()
            }
            .padding()
            .background(Color(red: 27/255, green: 178/255, blue: 115/255))
            .border(width: 3, edges: [.top, .bottom], color: .black)
            .onTapGesture {
                showIng.toggle()
            }
            if showIng{//shows every ingredient
                ForEach(ingredients, id: \.name){ingredient in                    IngredientView(ingredient: ingredient)
                }
            }
        }
    }
}
#Preview {
    RecipeView(vm: SearchViewModel())
}
