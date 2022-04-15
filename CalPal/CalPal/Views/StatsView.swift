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
    

 
    var body: some View {
        /** TODO: Allow options to display different statistics
                ex1: pie chart of categories
                ex2: histogram of week's categories
                ex3: histogram of hourly/day categories
         LogView demonstrates fetching data from db*/
        VStack{
              
            Text("Stats")
            Section(header: Text("Bar Chart")){
            }
            
            
        }.navigationTitle("Statistics")
 
    }

 
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}

