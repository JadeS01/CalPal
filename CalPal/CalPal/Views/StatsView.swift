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
    
    let chartStyle = ChartStyle(backgroundColor: Color.white, accentColor: Colors.GradientNeonBlue, secondGradientColor: .green, textColor: .black, legendTextColor: .black, dropShadowColor: .green )
    

 
    var body: some View {
        VStack{
            Picker("Stats", selection: $select){
                Text("Today").tag("Today")
                Text("All Time").tag("All Time")
            }.pickerStyle(.segmented).padding()
            
            
            if select == "All Time" {
                BarChartView(data: ChartData(values: pieChart()), title: "Meals of the Day", style: chartStyle, form: ChartForm.extraLarge)
                
            } else {
                BarChartView(data: ChartData(values: barChart()), title: "Consumed Today", style: chartStyle, form: ChartForm.extraLarge)
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
    
    private func pieChart() -> [(String, Double)]{
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
        return [("Breakfast", breakfast), ("Lunch", lunch), ("Snack", snack), ("Dinner", dinner)]
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

