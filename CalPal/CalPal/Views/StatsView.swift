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
    @State var categories = []
    
    let chartStyle = ChartStyle(backgroundColor: Color.black, accentColor: Colors.OrangeStart, secondGradientColor: Colors.OrangeEnd, textColor: Color.white, legendTextColor: Color.white, dropShadowColor: .green )
    

 
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
            }.pickerStyle(.segmented).padding()
            
            if select == "All Time" {
                PieChartView(data: pieChart(), title: "Meals of the Day", legend: "Category", form: ChartForm.large)
                
            } else {
                BarChartView(data: ChartData(values: barChart()), title: "Consumed Today", legend: "Legend", form: ChartForm.extraLarge)
            }
            
            
            Text("History").padding(20)
            List{
                ForEach(food) { food in
                        HStack {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(food.name!)
                                    .bold()
                                Text("\(Int(food.calories))") + Text(" calorie(s)").foregroundColor(.green)
                            }
                            Spacer()
                            VStack(alignment: .leading, spacing: 6) {
                                Text(food.category!)
                                Text(calcDate(date:food.date!))
                                    .foregroundColor(.gray).italic()
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
        return [breakfast, lunch, snack, dinner]
    }
    
    private func barChart() -> [(String, Double)] {
        var foods:[(String, Double)] = []
        for item in food {
            if Calendar.current.isDateInToday(item.date!){
                foods.append((item.name!, Double(item.calories)))
            }
        }
        return foods.reversed()
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}

