//
//  Task_ManagerApp.swift
//  Task Manager
//
//  Created by Riza Mamedov on 08.02.2024.
//

import SwiftUI

// Main App
@main
struct TaskManagerApp: App {
    // MARK: CoreData controller
    @StateObject private var dataService = DataService()

    var body: some Scene {
        WindowGroup {
            ContentView()
                // MARK: Passes the controller to the view
                .environment(\.managedObjectContext, dataService.container.viewContext)
        }
    }
}
