//
//  RecepiesView.swift
//  TempBuilder
//
//  Created by Abdulrahman.Alazrak on 2024-05-16.
//

import SwiftUI

struct RecepiesView: View {
    let vm = RecipeViewModel()
    let searchVM = SearchViewModel()

    @State var lists: [String] = []
    @State var selectedList = ""
    @State var recepies: [ReceptBasic] = []// the recepies shown on screen
    @State var popUp = false
    @State var feedbackText = ""
    @State var listNameInput = ""
    @State var feedbackColor = Color.green
    @State var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path){
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
                                Button(action: {
                                    searchVM.getRecepieInCode(theId: recepie.id, resultRecepie: { theRecepie in
                                        searchVM.currentRecepie = theRecepie
                                        DispatchQueue.global(qos: .background).async {//this chechs if the recepie has been updated then appends an int in the path which then makes so that the view navigates
                                            var tempBool = false
                                            repeat{
                                                if(theRecepie.id == searchVM.currentRecepie.id){
                                                    path.append(1)
                                                    tempBool = true
                                                }
                                            } while(!tempBool)
                                        }
                                    })
                                }, label: {
                                    AsyncImage(url: URL(string: searchVM.makeImage100x100(image: recepie.image, imageType: recepie.imageType)))//this method takes the image url then changes it so that the image is 90x90
                                        .padding(.leading, 10)
                                })

                                Spacer()//these spacers puts the image to the left, the text in the middle and the save button to the right.
                                    .frame(height: 0)
                                Text(recepie.title)
                                    .fontWeight(.bold)
                                    .frame(width: 150)
                                Spacer()
                                    .frame(height: 0)
                                Button(action: {
                                    vm.deleteRecepie(user: "tempGuy", list: selectedList, recepie: recepie, result: { result in
                                        if(result){
                                            recepies.removeAll(where: { aRecepie in
                                                aRecepie.id == recepie.id
                                            })
                                        } else{
                                            //here runs when deleting a recepie fails
                                        }
                                    })
                                }, label: {
                                    Image(systemName: "minus.circle")
                                        .scaleEffect(1.4)
                                        .foregroundStyle(.red)
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
                                    vm.addList(user: "tempGuy", listToAdd: listNameInput){result in
                                        if(result){
                                            feedbackColor = Color.green
                                            feedbackText = "Success"
                                            lists.append(listNameInput)
                                        } else{
                                            feedbackColor = Color.red
                                            feedbackText = "Failed"
                                        }
                                    }
                                }
                                
                            }
                        }
                        .padding(.top, 10)
                        Text(feedbackText)
                            .foregroundStyle(feedbackColor)
                            .padding(.top, 10)
                    }
                    .transition(.scale)
                    .frame(width: 320, height: 300)
                    .background(Color(red: 226/255, green: 234/255, blue: 226/255))
                    .cornerRadius(25)
                    .padding(.top, 170)
                }
            }
            .onAppear(perform: {
                vm.getLists(user: "tempGuy", result: {someLists in
                    self.lists = someLists
                })
            })
            .ignoresSafeArea()
            .navigationDestination(for: Int.self, destination: { navNum in
                if(navNum == 1){
                    RecipeView(vm: searchVM)
                }
            })
        }
    }
}
struct ListChoiceView: View {
    var myVM: RecipeViewModel
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
                    myVM.getListRecepies(user: "tempGuy" ,listName: option, result: {result in
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

#Preview {
    RecepiesView()
}
