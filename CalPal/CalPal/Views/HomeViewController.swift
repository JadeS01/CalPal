//
//  HomeViewController.swift
//  CalPal
//
//  Created by Jade Simien on 3/31/22.
//

import SwiftUI

struct HomeViewController: View {
    
    @State var showMenu = false


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
    
    @State var isRemOn: Bool = false
    

    var body: some View {
        VStack(alignment: .center){
            Text(greeting())
            Text("This is the home view!")
            Text("Today's Calories: \(todayCalories())")
           
            Spacer()
            Button("Water reminder"){
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("k")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
            Button("hi"){
                waterReminder()
            }
            
            Toggle(isOn: $isRemOn){
                Text("water")
            }
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

struct HomeViewController_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewController()
    }
}

