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
    @StateObject private var dataController2 = DataController2()
    
    var body: some Scene {
        WindowGroup {
            HomeViewController()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environment(\.managedObjectContext, dataController2.container2.viewContext)
        }
    }
}
