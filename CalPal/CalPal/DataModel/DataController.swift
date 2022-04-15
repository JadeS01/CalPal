//
//  DataController.swift
//  CalPal
//
//  Created by Jade Simien on 3/31/22.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "FoodModel")
    init() { // load data
        container.loadPersistentStores{ desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    
    func save(context: NSManagedObjectContext){
        do {
            try context.save()
            print("Saved data")
        } catch {
            print("Did not save data")
        }
    }
    
    
    func addFood(name: String, calories: Int, category: String, context: NSManagedObjectContext){
        let food = Food(context: context)
        food.id = UUID()
        food.date = Date()
        food.name = name
        food.calories = Int32(calories)
        food.category = category
        
        save(context: context)
    }
    
    func editFood(food: Food, name: String, calories: Int, category: String, context: NSManagedObjectContext){
        food.date = Date()
        food.name = name
        food.calories = Int32(calories)
        food.category = category
        
        save(context: context)
    }

}

class DataController2: ObservableObject {
    let container2 = NSPersistentContainer(name: "GoalModel")
    init() { // load data
        container2.loadPersistentStores{ desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext){
        do {
            try context.save()
            print("Saved data")
        } catch {
            print("Did not save data")
        }
    }
    
    func addGoal(goalCal: Int, context: NSManagedObjectContext){
        let goal = Goal(context: context)
        goal.goalCal = Int32(goalCal)
        save(context: context)
    }
    
    func editGoal(goal: Goal, goalCal: Int, context: NSManagedObjectContext){
        goal.goalCal = Int32(goalCal)
        save(context: context)
    }
    
}

