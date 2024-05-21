//
//  MenuBar.swift
//  FitnessApp
//
//  Created by Elin.Andersson on 2024-05-21.
//

import Foundation
import SwiftUI

struct MenuBar: View {
    var body: some View {
        HStack {
            Spacer()
            Text("Workout App")
                .font(.headline)
                .foregroundColor(Color(red: 27/255, green: 178/255, blue: 115/255))
            Spacer()
            Image(systemName: "line.horizontal.3")
                .foregroundColor(Color(red: 27/255, green: 178/255, blue: 115/255))
                .padding(.trailing, 20)
        }
        .padding()
        .background(Color.white)
    }
}
struct MenuBar_Previews: PreviewProvider {
    static var previews: some View {
        MenuBar().environmentObject(WorkoutData())
    }
}
