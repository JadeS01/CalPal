//
//  CalPalApp.swift
//  CalPal
//
//  Created by Jade Simien on 3/31/22.
//

import SwiftUI
@main
struct CalPalApp: App {
    @StateObject private var dataController = DataController()
    @AppStorage("isDarkMode") private var isDarkMode = false
    var body: some Scene {
        WindowGroup {
            HomeViewController()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(Goal(goal: 1200))
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
