//
//  EditView.swift
//  CalPal
//
//  Created by Jade Simien on 3/31/22.
//

import SwiftUI

struct EditView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    private var food: FetchedResults<Food>.Element
    
    @State private var name = ""
    @State private var calories = 0
    @State private var category = ""
    private var categories = ["snack", "breakfast", "lunch", "dinner"]
    
    var body: some View {
        Form {
            Section {
                TextField("\(food.name!)", text: $name)
                    .onAppear{
                        name = food.name!
                        calories = Int(food.calories)
                    }
                VStack {
                    TextField("Calories", value: $calories, format: .number)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.decimalPad)
                        .padding()
                    Text("\(calories) calories")
                }
                .padding()
                
                Menu{
                    ForEach(categories, id: \.self) { obj in
                        Button(obj) {
                            self.category = obj
                        }
                    }
                } label: {
                    VStack(spacing: 5){
                        HStack{
                            Text(category.isEmpty ? "Select category" : category)
                                .foregroundColor(category.isEmpty ? .gray : .black)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundColor(Color.green)
                                .font(Font.system(size: 20, weight: .bold))
                            }
                            .padding(.horizontal)
                    }
                }
                
                HStack{
                    Spacer()
                    Button("Submit"){
                        DataController().editFood(food: food, name: name, calories: calories, category: category, context: managedObjectContext)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}
