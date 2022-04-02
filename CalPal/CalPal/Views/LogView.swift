//
//  LogView.swift
//  CalPal
//
//  Created by Jade Simien on 3/31/22.
//

// reference https://www.youtube.com/watch?v=O0FSDNOXCl0
import SwiftUI
import CoreData

struct LogView: View {
    /** TODO: Edit fetch request to only display the current day's log AND
            fix edit/EditView.*/
    @Environment(\.managedObjectContext) var managedObjectContext
    // gets the most recent dates
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var food: FetchedResults<Food>
    
    @State private var showAddView = false
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                Text("\(Int(todayCalories())) total calorie(s) today")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                List{
                    ForEach(food) { food in
                        NavigationLink(destination: Text("\(food.calories)")){
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(food.name!)
                                        .bold()
                                    Text("\(Int(food.calories))") + Text(" calorie(s)").foregroundColor(.red)
                                }
                                Spacer()
                                Text(calcDate(date:food.date!))
                                    .foregroundColor(.gray).italic()
                            }
                        }
//                        NavigationLink(destination: EditView(food: food)){
//                            HStack {
//                                VStack(alignment: .leading, spacing: 6) {
//                                    Text(food.name!)
//                                        .bold()
//                                    Text("\(Int(food.calories))") + Text(" calorie(s)").foregroundColor(.red)
//                                }
//                                Spacer()
//                                Text(calcDate(date:food.date!))
//                                    .foregroundColor(.gray).italic()
//                            }
//                        }
                    }
                    .onDelete(perform: deleteFood)
                }
                .listStyle(.plain)
            }
        }.navigationTitle("Today's Log")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddView.toggle()
                    } label: {
                        Label("Add Food", systemImage: "plus.circle").foregroundColor(.green)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading){
                    EditButton()
            }
        }
        .sheet(isPresented: $showAddView){
            AddView()
        }
    }
    
    private func deleteFood(offsets: IndexSet) {
        withAnimation {
            offsets.map {food[$0]}.forEach(managedObjectContext.delete)
            
            DataController().save(context: managedObjectContext)
        }
    }
    
    private func todayCalories() -> Int32 {
        var todayCalories: Int32 = 0
        for item in food {
            if Calendar.current.isDateInToday(item.date!){
                todayCalories += item.calories
            }
        }
        return todayCalories
    }
}

struct LogView_Previews: PreviewProvider {
    static var previews: some View {
        LogView()
    }
}
