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

func greeting() -> String{
    var greeting = ""
    let date = NSDate()
    let calendar = NSCalendar.current
    let currentHour = calendar.component(.hour, from: date as Date)
    let hourInt = Int(currentHour.description)!
    
    if hourInt >= 12 && hourInt <= 16 {
        greeting = "Good Afternoon"
    }
    else if hourInt >= 3 && hourInt <= 12 {
        greeting = "Good Morning"
    }
    else if hourInt >= 16 && hourInt <= 20 {
        greeting = "Good Evening"
    }
    else if hourInt >= 20 && hourInt <= 3 {
        greeting = "Good Night"
    }
    return greeting
}
