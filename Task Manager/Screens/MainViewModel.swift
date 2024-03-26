//
//  MainViewModel.swift
//  Task Manager
//
//  Created by Riza Mamedov on 09.03.2024.
//

import SwiftUI
import CoreData


class MainViewModel: ObservableObject, ViewModelsType {
    @Published var currentTab: AppTab = AppConstants.defaultAppTab
    
    @Published var openTaskEditScreen: Bool = false
    @Published var taskTitle: String = ""
    @Published var taskColor: TaskColor = AppConstants.defaultTaskColor
    @Published var taskDeadline: Date = AppConstants.defaultTaskDate
    @Published var taskType: TaskTypes = .basic
    
    @Published var editTask: Task?
    
    func toDefaults() -> Void {
        openTaskEditScreen = false
        taskTitle = ""
        taskColor = AppConstants.defaultTaskColor
        taskDeadline = Date()
        taskType = AppConstants.defaultTaskType
        
        editTask = nil
    }
    
    func setupTask() -> Void {
        if let editTask = editTask {
            self.taskTitle = editTask.title ?? ""
            self.taskColor = TaskColor(rawValue: editTask.color!) ?? AppConstants.defaultTaskColor
            self.taskDeadline = editTask.deadline ?? Date()
            self.taskType = TaskTypes(rawValue: editTask.type!) ?? AppConstants.defaultTaskType
        }
    }
    
    func openEditScreen(task: Task, _ action: @escaping () -> Void) -> Void {
        editTask = task
        openTaskEditScreen = true
        action()
    }
}
