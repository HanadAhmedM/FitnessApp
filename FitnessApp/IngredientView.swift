import SwiftUI

struct IngredientView: View {
    var ingredient: extendedIngredient
    var body: some View {
        VStack(alignment: .leading, spacing: 3){
            HStack{
                Text(ingredient.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading, 10)
                Spacer()
                AsyncImage(url: URL(string: "https://spoonacular.com/cdn/ingredients_100x100/".appending(ingredient.image)))
            }
            HStack{
                Spacer()
                Text(ingredient.original)
                    .padding()
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .font(.title3)
                Spacer()
            }

        }
        .background(Color(hue: 0.33, saturation: 0.16, brightness: 0.90))
        .cornerRadius(20)
        
        .padding(.horizontal, 5)
    }
}

#Preview {
    IngredientView(ingredient: extendedIngredient(aisle: "", amount: 0.0, consistency: "", image: "butter-sliced.jpg", id: 0, name: "butter", nameClean: "", original: "2 tbsp fr fr", originalName: "", unit: "", meta: [], measures: Measures(us: Measure(amount: 0.0, unitShort: "", unitLong: ""), metric: Measure(amount: 0.0, unitShort: "", unitLong: ""))))
}
