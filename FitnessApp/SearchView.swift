//
//  SearchView.swift
//  FitnessApp
//
//  Created by Abdulrahman.Alazrak on 2024-05-06.
//

import SwiftUI

struct SearchView: View {
    @State var searchText = ""
    @State var items: [String: String] = [:]//These "query-value" items get used later on in the URL
    @ObservedObject var vm = SearchViewModel()
    var body: some View {
        NavigationStack{
            ZStack{
                Color(red: 27/255, green: 178/255, blue: 115/255)
                    .ignoresSafeArea()
                VStack(spacing: 0){
                    Text("Lets find some good\n recipe!")
                        .font(.system(size: 25, weight: .bold))
                        .foregroundStyle(.black)
                        .padding(.top, 75)
                        .padding(.bottom, 13)
                        .multilineTextAlignment(.center)
                        .lineSpacing(6.0)
                    VStack{
                        HStack{
                            TextField("", text: $searchText, prompt: Text("Search recipe...").foregroundStyle(Color(red: 137/255, green: 137/255, blue: 137/255)))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.leading, 10)
                            Button(action: {
                                items.updateValue(searchText, forKey: "query")
                                vm.getRecepies(theItems: items)
                            }, label: {
                                Image(systemName: "magnifyingglass")
                                    .frame(width: 10, height: 10)
                                    .padding()
                                    .background(.gray)
                                    .foregroundStyle(.white)
                                    .cornerRadius(8.0)
                            })
                            
                            NavigationLink(destination: {
                                FilterView(items: $items)//filter view gets the items then changes them
                            }, label: {
                                Image(systemName: "line.horizontal.3.decrease.circle")
                                    .frame(width: 10, height: 10)
                                    .padding()
                                    .background(Color.green)
                                    .cornerRadius(8.0)
                                    .foregroundColor(.white)
                            })
                            .padding(.trailing, 10)

                        }
                        .padding(.top, 25)
                        ScrollView(){
                            ForEach(vm.currentRecepies){recepie in
                                HStack{
                                    AsyncImage(url: URL(string: vm.makeImage100x100(image: recepie.image, imageType: recepie.imageType)))//this method takes the image url then changes it so that the image is 90x90
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
                        .padding(.top, 10)
                        
                    }
                    .background(Color(red: 226/255, green: 234/255, blue: 226/255))
                    .cornerRadius(25)
                }
                .ignoresSafeArea()
            }
        }
    }
}
struct EdgeBorder: Shape {//idk got it from the internet it fixes so that you can have borders in different places
    var width: CGFloat
    var edges: [Edge]
    func path(in rect: CGRect) -> Path {
        edges.map { edge -> Path in
            switch edge {
            case .top: return Path(.init(x: rect.minX, y: rect.minY, width: rect.width, height: width))
            case .bottom: return Path(.init(x: rect.minX, y: rect.maxY - width, width: rect.width, height: width))
            case .leading: return Path(.init(x: rect.minX, y: rect.minY, width: width, height: rect.height))
            case .trailing: return Path(.init(x: rect.maxX - width, y: rect.minY, width: width, height: rect.height))
            }
        }.reduce(into: Path()) { $0.addPath($1) }
    }
}

// View extension for applying borders to specified edges
extension View {//idk got it from the internet it fixes so that you can have borders in different places
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}

#Preview {
    SearchView()
}
