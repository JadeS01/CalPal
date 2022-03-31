//
//  DateForm.swift
//  CalPal
//
//  Created by Jade Simien on 3/31/22.
//

import Foundation

func calcDate(date: Date) -> String {
    let minutes = Int(-date.timeIntervalSinceNow)/60
    let hours = minutes/60
    let days = hours/24
    
    if minutes < 129 {
        return "\(minutes) minute(s) ago"
    } else if minutes >= 120 && hours < 48 {
        return "\(hours) hour(s) ago"
    } else {
        return "\(days) day(s) ago"
    }
}
