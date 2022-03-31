//
//  LogView.swift
//  CalPal
//
//  Created by Jade Simien on 3/31/22.
//

import SwiftUI

struct LogView: View {
    @Environment (\.managedObjectContext) var managedObjectContext
    @Environment (\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var calories = 0
    @State private var category = ""
    private var categories = ["snack", "breakfast", "lunch", "dinner"]
    
    var body: some View {
        Form{
            Section{
                /** TODO: Fetch calories from API*/
                // temporary food log form
                TextField("Name", text: $name)
                
                TextField("Calories", value: $calories, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                    .padding()
                Text("\(calories) calories")
                
                // reference: https://medium.com/geekculture/custom-drop-down-text-field-in-swiftui-a748d2cebbeb
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
                
                HStack {
                    Spacer()
                    Button("Add Food"){
                        DataController().addFood(name: name, calories: calories, category: category, context: managedObjectContext)
                        dismiss()
                    }
                    Spacer()
                    
                }
            }
        }.navigationTitle("Calorie Log")
    }
}

struct LogView_Previews: PreviewProvider {
    static var previews: some View {
        LogView()
    }
}
