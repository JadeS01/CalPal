//
//  GoalCalory.swift
//  CalPal
//
//  Created by Arslan Alimov on 4/5/22.
//

import Foundation
//helper for Global Goal.
//final class GoalCalory:ObservableObject{
//    static let global=GoalCalory()
//    var goalCal="0"
//
//}

class Goal: ObservableObject {
    @Published var goal: Int
    init(goal: Int){
        self.goal = goal
    }
}
