//
//  ProfileView.swift
//  CalPal
//
//  Created by Jade Simien on 3/31/22.
//

import SwiftUI

struct ProfileView: View {
    @State private var goalCal = 0
    private let defaults = UserDefaults.standard
    var body: some View {
        VStack(alignment: .center){
            Text("Current Goal: \(goalCal) calories").font(.headline)
            Image(systemName: "person")
                .foregroundColor(.green)
                .imageScale(.large).padding()
            Text("Set your daily calorie goal\n\n")
            VStack{
                TextField("####", value: $goalCal, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                    .padding()
            }
            HStack {
                Spacer()
                Button("Confirm"){
//                    DataController().addGoal(goalCal: goalCal, context: managedObjectContext)
                    self.save()
                    self.load()
                }
                Spacer()
                
            }
            if goalCal < 1200 {
                Text("\n*Please take caution with your health.")
            }
            else if goalCal > 5000 {
                Text("\n*Please take caution with your health.")
            }
        }.navigationTitle("Profile")
            .onAppear(perform: load)
    }
    
    func save() {
        defaults.set(goalCal, forKey: "goalCal")
    }
    
    func load() {
        let savedGoal = defaults.integer(forKey: "goalCal")
        goalCal = savedGoal ?? 0
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
