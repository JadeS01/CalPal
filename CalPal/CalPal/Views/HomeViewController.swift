//
//  HomeViewController.swift
//  CalPal
//
//  Created by Jade Simien on 3/31/22.
//

import SwiftUI

struct HomeViewController: View {
    
    @State var showMenu = false
    @EnvironmentObject private var goal: Goal
    

    var body: some View {
        
        let closeMenu = DragGesture()
            .onEnded{
                if $0.translation.width < -100{
                    withAnimation {
                        self.showMenu = false
                    }
                }
            }
        
        return NavigationView {
            
            GeometryReader{ geometry in
            
                ZStack(alignment: .trailing){
                    MainView(showMenu: self.$showMenu)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: self.showMenu ? geometry.size.width/2 : 0)
                        .disabled(self.showMenu ? true : false)
    //                MainView()
    //                    .frame(width: geometry.size.width, height: geometry.size.height)
                    if self.showMenu {
                        MenuView().frame(width: geometry.size.width/2.22)
                            .transition(.move(edge: .trailing))
                    }
                }.gesture(closeMenu)
            }
            .navigationBarTitle("Cal-Pal", displayMode: .inline)
             
            .navigationBarItems(trailing: (
                Button(action: {
                    withAnimation {
                        self.showMenu.toggle()
                    }
                }) {
                    Image(systemName: "line.horizontal.3")
                        .imageScale(.large)
                    }
            ))
            .navigationBarItems(leading: (
                Text("LOGO")))
        }
    }
}

struct MainView: View {
    /** TODO: Create a function that subtracts the day's total calories from the goal calories and
            display whether user has yet to meet their goal or has gone over it. LogView has the
            function showing the day's total calories*/
    @Binding var showMenu: Bool
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var food: FetchedResults<Food>
    @EnvironmentObject private var goal: Goal
    @AppStorage("goalCal") private var goalCal = 0
    
    
    var body: some View {
        VStack(alignment: .center){
            Text(greeting())
            Text("This is the home view!")
            Text("Today's Calories: \(todayCalories())")
            Text("Remaining Calories: \(remCal())")
            Text("Goal: \(goalCalories())")
            Spacer()
           
        }
    }
    
    private func goalCalories() -> Int {
        if goal.goal > 1200 {
            goalCal = goal.goal
            return goalCal
        }
        return goalCal
    }
    
    private func remCal() -> Int {
        let goal = goalCalories()
        let today = Int(todayCalories())
        let rem = goal - today
        return rem
    }
    
    private func todayCalories() -> Int32 {
        var todayCalories: Int32 = 0
        for item in food {
            if Calendar.current.isDateInToday(item.date!){
                todayCalories += Int32(item.calories)
            }
        }
        return todayCalories
    }
    
}

struct HomeViewController_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewController()
    }
}

