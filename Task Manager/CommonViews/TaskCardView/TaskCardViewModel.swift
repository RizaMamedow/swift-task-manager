//
//  TaskCardViewModel.swift
//  Task Manager
//
//  Created by Riza Mamedov on 10.03.2024.
//

import SwiftUI
import CoreData


@MainActor
class TaskCardViewModel: ObservableObject {
    @Published private var appViewModel: MainViewModel
    
    @Published var task: Task
    @Published var editTask: Task
    
    init(appViewModel: MainViewModel, task: Task) {
        self.appViewModel = appViewModel
        
        self.task = task
        self.editTask = appViewModel.editTask ?? Task.init()
    }
    
    public func toggleTaskStatus(
        _ task: Task,
        context moc: NSManagedObjectContext
    ) -> Void {
        task.objectWillChange.send()
        task.isComplete.toggle()
        try? moc.save()
    }
    
    public func openTaskScreen(task: Task) {
        appViewModel.openEditScreen(task: task) { [self] in
            self.setupTask()
        }
    }
    
    public func setupTask() -> Void { appViewModel.setupTask() }
    
    public var currentTab: AppTab { return appViewModel.currentTab }
}
