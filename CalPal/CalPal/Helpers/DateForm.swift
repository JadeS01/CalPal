//
//  DateForm.swift
//  CalPal
//
//  Created by Jade Simien on 3/31/22.
//

import Foundation
import UserNotifications

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


 
extension Calendar {
    static let iso8601 = Calendar(identifier: .iso8601)
    static let gregorian = Calendar(identifier: .gregorian)
}

extension Date {
    func byAdding(component: Calendar.Component, value: Int, wrappingComponents: Bool = false, using calendar: Calendar = .current) -> Date? {
        calendar.date(byAdding: component, value: value, to: self, wrappingComponents: wrappingComponents)
    }
    func dateComponents(_ components: Set<Calendar.Component>, using calendar: Calendar = .current) -> DateComponents {
        calendar.dateComponents(components, from: self)
    }
    func startOfWeek(using calendar: Calendar = .current) -> Date {
        calendar.date(from: dateComponents([.yearForWeekOfYear, .weekOfYear], using: calendar))!
    }
    var noon: Date {
        Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    func daysOfWeek(using calendar: Calendar = .current) -> [Date] {
        let startOfWeek = self.startOfWeek(using: calendar).noon
        return (0...6).map { startOfWeek.byAdding(component: .day, value: $0, using: calendar)! }
    }
}

func waterReminder() {
    let content = UNMutableNotificationContent()
    content.title = "Drink some water!"
    content.subtitle = "Please :D"
    content.sound = UNNotificationSound.default
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: true)
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(request)
}
