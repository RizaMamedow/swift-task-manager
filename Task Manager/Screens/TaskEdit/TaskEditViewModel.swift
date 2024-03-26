//
//  ViewModel.swift
//  Task Manager
//
//  Created by Riza Mamedov on 09.03.2024.
//

import SwiftUI
import CoreData

class TaskEditViewModel: ObservableObject, ViewModelsType {
    @Published private var appViewModel: MainViewModel
    
    @Published var currentTab: AppTab
    @Published var openTaskEditScreen: Bool
    @Published var taskTitle: String
    @Published var taskColor: TaskColor
    @Published var taskDeadline: Date
    @Published var taskType: TaskTypes
    @Published var editTask: Task?
    
    @Published var openDatePicker: Bool = false
    
    init(appViewModel: MainViewModel) {
        self.appViewModel = appViewModel
        
        self.currentTab = appViewModel.currentTab
        self.openTaskEditScreen = appViewModel.openTaskEditScreen
        self.taskTitle = appViewModel.taskTitle
        self.taskColor = appViewModel.taskColor
        self.taskDeadline = appViewModel.taskDeadline
        self.taskType = appViewModel.taskType
        self.editTask = appViewModel.editTask
    }
    
    
    
    var isSaveButtonDisabled: Bool {
        return self.taskTitle == ""
    }
    
    var buttonOpacity: Float {
        return self.isSaveButtonDisabled ? 0.6 : 1
    }
    
    var trashButtonVisibility: Double {
        return self.appViewModel.editTask != nil ? 1 : 0
    }
    
    var isDatePickerOpen: Bool {
        return self.openDatePicker
    }
    
    var taskFormattedDeadline: String{
        return self.taskDeadline.formatted(date: .abbreviated, time: .omitted) + "," + self.taskDeadline.formatted(date: .omitted, time: .shortened)
    }
    
    func closeDatePicker() -> Void {
        self.openDatePicker = false
    }
    
    func toDefaults() {
        self.appViewModel.toDefaults()
    }
    
    public func addTask(context moc: NSManagedObjectContext) -> Bool {
        let task: Task!
        if let editTask = editTask {
            task = editTask
        } else {
            task = Task(context: moc)
        }
        
        task.title = taskTitle
        task.color = taskColor.rawValue
        task.deadline = taskDeadline
        task.type = taskType.rawValue
        task.isComplete = false
        
        if let _ = try? moc.save(){
            return true
        }
        return false
    }
    
}

