//
//  AddRecipeView.swift
//  TempBuilder
//
//  Created by Abdulrahman.Alazrak on 2024-05-23.
//

import SwiftUI

struct AddRecipeView: View {
    let vm = RecipeViewModel()
    let calenderVm = CalenderViewModel(user: "tempGuy")
    let day: String
    let time: String
    @State var lists: [String] = []
    @State var selectedList = ""
    @State var recepies: [ReceptBasic] = []// the recepies shown on screen
    @State var feedbackText = ""
    @State var feedbackColor = Color.green
    var body: some View {
        ZStack(alignment: .top){
            Color(red: 27/255, green: 178/255, blue: 115/255)
            Color.white
                .cornerRadius(25)
                .padding(.top, 120)
            Text("Recepies")
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .font(.largeTitle)
                .padding(.top, 50)
            VStack{
                HStack{
                    ListChoiceView(myVM: vm ,myRecepies: $recepies ,mySelectedList: $selectedList, options: lists)
                }
                Text(feedbackText)
                    .foregroundStyle(feedbackColor)
                    .fontWeight(.bold)
                    .padding(.top, 10)
                ScrollView{
                    ForEach(recepies){recepie in
                        HStack{
                            AsyncImage(url: URL(string: vm.makeImage90x90(image: recepie.image, imageType: recepie.imageType)))//this method takes the image url then changes it so that the image is 90x90
                                .padding(.leading, 10)

                            Spacer()//these spacers puts the image to the left, the text in the middle and the save button to the right.
                                .frame(height: 0)
                            Text(recepie.title)
                                .fontWeight(.bold)
                                .frame(width: 150)
                            Spacer()
                                .frame(height: 0)
                            Button(action: {
                                calenderVm.saveRecipe(day: day, time: time, recepie: recepie){ result in
                                    if(result){
                                        feedbackText = "Saved succesfully!"
                                        feedbackColor = Color.green

                                    } else {
                                        feedbackText = "Error saving!"
                                        feedbackColor = Color.red
                                    }
                                }
                            }, label: {
                                Image(systemName: "plus.circle")
                                    .scaleEffect(1.4)
                                    .foregroundStyle(.green)
                            })
                            .padding(.trailing, 15)
                        }
                    }
                }
                .frame(width: 390)
                .background()
            }
            .frame(width: 390)
            .ignoresSafeArea()
            .cornerRadius(25)
            .padding(.top, 135)
        }
        .onAppear(perform: {
            vm.getLists(user: "tempGuy", result: {someLists in
                self.lists = someLists
            })
        })
        .ignoresSafeArea()
    }
}

#Preview {
    AddRecipeView(day: "3", time: "frukost")
}
