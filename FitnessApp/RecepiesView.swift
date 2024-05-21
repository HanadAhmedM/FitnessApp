//
//  RecepiesView.swift
//  TempBuilder
//
//  Created by Abdulrahman.Alazrak on 2024-05-16.
//

import SwiftUI

struct RecepiesView: View {
    let vm = RecepieViewModel()
    @State var lists: [String] = []
    @State var selectedList = ""
    @State var recepies: [ReceptBasic] = []// the recepies shown on screen
    @State var popUp = false
    @State var feedbackText = ""
    @State var listNameInput = ""
    @State var feedbackColor = Color.green
    @Binding var selectedDay: String
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
                    Button(action: {
//                        if(!vm.lists.contains("newList")){
//                            vm.addList(listToAdd: "newList")
//                        }
                        withAnimation(Animation.easeIn(duration: 0.5)){
                            popUp.toggle()
                        }

                    }, label: {
                        Text("+")
                            .foregroundStyle(.black)
                            .font(.title)
                            .frame(width: 35, height: 35)
                            .background(Color(red: 27/255, green: 178/255, blue: 115/255))
                            .cornerRadius(25)
                    })
                }
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
                                print("")
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
            if(popUp){
                Color(red: 27/255, green: 178/255, blue: 115/255).opacity(0.9)
                    .transition(.opacity)
                VStack{
                    Text("Add a list")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    TextField("", text: $listNameInput, prompt: Text("list name...").foregroundStyle(Color(red: 137/255, green: 137/255, blue: 137/255)))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 200)
                    HStack{
                        Button("cancel", action: {
                            withAnimation(Animation.linear){
                                feedbackText = ""
                                popUp.toggle()
                            }
                        })
                        .foregroundStyle(.red)
                        Button("add"){
                            if(!lists.contains(listNameInput) && !listNameInput.isEmpty){
                                vm.addList(listToAdd: listNameInput){result in
                                    if(result){
                                        feedbackText = "Success"
                                        feedbackColor = Color.green
                                        lists.append(listNameInput)
                                    } else{
                                        feedbackText = "Failed"
                                        feedbackColor = Color.red
                                    }
                                }
                            }

                        }
                    }
                    .padding(.top, 10)
                    Text(feedbackText)
                        .foregroundStyle(feedbackColor)
                }
                .transition(.scale)
                .frame(width: 320, height: 300)
                .background(Color(red: 226/255, green: 234/255, blue: 226/255))
                .cornerRadius(25)
                .padding(.top, 170)
            }
        }
        .onAppear(perform: {
            vm.getLists(result: {someLists in
                self.lists = someLists
            })
        })
        .ignoresSafeArea()
    }
}
struct ListChoiceView: View {
    var myVM: RecepieViewModel
    @Binding var myRecepies: [ReceptBasic]
    @Binding var mySelectedList: String
    var options: [String]
    @State var selectText: String = "- select -"
    
    var body: some View {
        Menu(content: {
            ForEach(options, id: \.hashValue){ option in
                Button(option){
                    selectText = option
                    mySelectedList = option
                    myVM.getListRecepies(listName: option, result: {result in
                        myRecepies = result
                    })
                }
            }
        }, label: {
            HStack(spacing: 0){
                Text(selectText)
                    .padding()
                    .background(.white)
                    .foregroundStyle(.black)
                    .border(width: 3, edges: [.leading,.top, .bottom], color: .black)
                Image(systemName: "chevron.up")
                    .frame(width: 30, height: 52)
                    .background(Color(red: 27/255, green: 178/255, blue: 115/255))
                    .foregroundStyle(.black)
                    .border(width: 3, edges: [.leading, .trailing, .top, .bottom], color: .black)

            }
        })
        .onAppear(perform: {
            if(mySelectedList != ""){
                selectText = mySelectedList
            }
            else{
                selectText = "Choose a list to view"
            }
        })
    }
}


struct RecepiesView_Previews: PreviewProvider {
    static var previews: some View {
        RecepiesView(selectedDay: .constant("M"))
    }
}
