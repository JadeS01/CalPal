//
//  ProfileView.swift
//  CalPal
//
//  Created by Jade Simien on 3/31/22.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var goal: Goal
    
    private let defaults = UserDefaults.standard
    
    var body: some View {
        VStack(alignment: .center){
            Text("Current Goal: \(goal.goal) calories").font(.headline)
            Image(systemName: "person") 
                .foregroundColor(.green)
                .imageScale(.large).padding()
            Text("Set your daily calorie goal\n\n")
            VStack{
                TextField("####", value: $goal.goal, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                    .padding()
            }
            HStack {
                Spacer()
                Button("Confirm"){
                    print(goal.goal)
                    self.save()
                    self.load()
                }
                Spacer()
                
            }
            if goal.goal < 1200 {
                Text("\n*Please take caution with your health.")
            }
            else if goal.goal > 5000 {
                Text("\n*Please take caution with your health.")
            }
        }.navigationTitle("Profile")
            .onAppear(perform: load)
    }
    
    func save() {
        defaults.set(goal.goal, forKey: "goalCal")
    }
    
    func load() {
        let savedGoal = defaults.integer(forKey: "goalCal")
        goal.goal = savedGoal
    }
   

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }}
}

