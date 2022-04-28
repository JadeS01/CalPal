//
//  StatsView.swift
//  CalPal
//
//  Created by Jade Simien on 3/31/22.
//

import SwiftUI
import CoreData
import SwiftUICharts

struct StatsView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    // gets the most recent dates
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var food: FetchedResults<Food>
    @State private var select = "Today"

 
    var body: some View {
        /** TODO: Allow options to display different statistics
                ex1: pie chart of categories
                ex2: histogram of week's categories
                ex3: histogram of hourly/day categories
         LogView demonstrates fetching data from db*/
        VStack{
            Picker("Stats", selection: $select){
                Text("Today").tag("Today")
                Text("All Time").tag("All Time")
            }.pickerStyle(.segmented)
            Text(select)
            
            MultiLineChartView(data: [([8,32,11,23,40,28], GradientColors.green), ([90,99,78,111,70,60,77], GradientColors.purple), ([34,56,72,38,43,100,50], GradientColors.orngPink)], title: "Title")
            
            if select == "Today" {
                Text("today")
                PieChartView(data: pieChart(), title: "Title1", legend: "Legendary") // legend is optional
            } else {
                Text("all time")
                BarChartView(data: ChartData(points: [8,23,54,32,12,37,7,23,43]), title: "Title", legend: "Legendary") // legend is optional
            }
            
            List{
                ForEach(allFood()) { food in
                    NavigationLink(destination: Text("\(food.calories)")){
                        HStack {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(food.name!)
                                    .bold()
                                Text("\(Int(food.calories))") + Text(" calorie(s)").foregroundColor(.red)
                            }
                            Spacer()
                            VStack(alignment: .leading, spacing: 6) {
                                Text(food.category!)
                                Text(calcDate(date:food.date!))
                                    .foregroundColor(.gray).italic()
                            }
                        }
                    }
                }
            }.listStyle(.plain)
            
        }.navigationTitle("Statistics")
 
    }
    
    private func pieChart() -> [Double]{
        var breakfast = 0.0
        var lunch = 0.0
        var snack = 0.0
        var dinner = 0.0
        for item in food {
            if item.category == "breakfast"{
                breakfast += Double(item.calories)
                
            }else if item.category == "lunch" {
                lunch += Double(item.calories)
            }else if item.category == "dinner"{
                dinner += Double(item.calories)
            }else{
                snack += Double(item.calories)
            }
        }
        print(breakfast, lunch, snack, dinner)
        return [breakfast, lunch, snack, dinner]
    }

    private func todayFood() -> [Food] {
        var todayFood: [Food] = []
        for item in food {
            if Calendar.current.isDateInToday(item.date!){
                todayFood.append(item)
            }
        }
        return todayFood
    }
    
    private func allFood() -> [Food] {
        var allFood: [Food] = []
        for item in food {
            allFood.append(item)
        }
        return allFood
    }
 
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}

