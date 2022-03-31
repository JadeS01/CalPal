//
//  ProfileView.swift
//  CalPal
//
//  Created by Jade Simien on 3/31/22.
//

import SwiftUI

struct ProfileView: View {
    // figure out how to always store
    @State private var calories = 1200
    var body: some View {
        VStack(alignment: .center){
            Image(systemName: "person")
                .foregroundColor(.green)
                .imageScale(.large).padding()
            Text("Set your daily calorie goal\n\n")
            Form {
                TextField("####", value: $calories, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                    .padding()
            }
            Text("Goal: \(calories) calories")
            if calories < 1200 {
                Text("\n*Please take caution with your health.")
            }
            else if calories > 5000 {
                Text("\n*Please take caution with your health.")
            }
        }.navigationTitle("Profile")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
