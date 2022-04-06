//
//  ProfileView.swift
//  CalPal
//
//  Created by Jade Simien on 3/31/22.
//

import SwiftUI

struct ProfileView: View {
    @State private var goalCal = 0
    //making observed object in order for us to set globalVariable further
    @ObservedObject var globalObject=GoalCalory.global
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
                    
                    globalObject.goalCal=goalCal
                    //Debugging setting goalCal to Global Object
                    print(GoalCalory.global.goalCal)
                    //TestApiCall
                    //PrintApiTest()
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
    func PrintApiTest(){
        var response : [Response] = []
        var _ : String
        ApiCalorieNinja().LoadDataApi(searchQuery: "10 oz Onion and tomato"){ (dataResponse) in
             response = [dataResponse]
    }
}
    
    func load() {
        let savedGoal = defaults.integer(forKey: "goalCal")
        goalCal = savedGoal
    }
   

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }}
}
