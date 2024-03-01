//
//  TaskViewModel.swift
//  Task Manager (iOS)
//
//  Created by Riza Mamedov on 08.02.2024.
//

import SwiftUI
import CoreData


class TaskViewModel: ObservableObject {
    @Published var currentTab: AppTab = AppConstants.defaultAppTab
    
    @Published var openTaskManipulateScreen: Bool = false
    @Published var taskTitle: String = ""
    @Published var taskColor: TaskColor = .yellow
    @Published var taskDeadline: Date = Date()
    @Published var taskType: TaskTypes = .basic
    @Published var openDatePicker: Bool = false
    
    @Published var editTask: Task?
    
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
    
    func toDefaults() -> Void {
        openTaskManipulateScreen = false
        taskTitle = ""
        taskColor = AppConstants.defaultTaskColor
        taskDeadline = Date()
        taskType = AppConstants.defaultTaskType
        
        editTask = nil
    }
    
    func setupTask() -> Void {
        if let editTask = editTask {
            taskTitle = editTask.title ?? ""
            taskColor = TaskColor(rawValue: editTask.color!) ?? AppConstants.defaultTaskColor
            taskDeadline = editTask.deadline ?? Date()
            taskType = TaskTypes(rawValue: editTask.type!) ?? AppConstants.defaultTaskType
        }
    }
    
    func toggleTaskStatus(
        _ task: Task,
        context moc: NSManagedObjectContext
    ) -> Void {
        task.objectWillChange.send()
        task.isComplete.toggle()
        try? moc.save()
    }
    
    func getDynamicPredicate() -> NSPredicate {
        let calendar = Calendar.current
        let filterKey = "deadline"
        
        switch currentTab {
            case .today:
                let today = calendar.startOfDay(for: Date())
                return NSPredicate(
                    format: "\(filterKey) >= %@ AND \(filterKey) < %@ AND isComplete == %i",
                    argumentArray: [ today, calendar.date(byAdding: .day, value: 1, to: today)!, 0]
                )
            case .upcoming:
                return NSPredicate(
                    format: "\(filterKey) >= %@ AND \(filterKey) < %@ AND isComplete == %i",
                    argumentArray: [calendar.startOfDay(for: calendar.date(byAdding: .day, value: 1, to: Date())!), Date.distantFuture, 0]
                )
            case .failed:
                return NSPredicate(
                    format: "\(filterKey) >= %@ AND \(filterKey) < %@ AND isComplete == %i",
                    argumentArray: [calendar.startOfDay(for: Date()), Date.distantPast, 0]
                )
            case .done:
                return NSPredicate(
                    format: "isComplete == %i",
                    argumentArray: [1]
                )
        }
        
//        if currentTab == .today {
//            let today = calendar.startOfDay(for: Date())
//
//            return NSPredicate(
//                format: "\(filterKey) >= %@ AND \(filterKey) < %@ AND isComplete == %i",
//                argumentArray: [ today, calendar.date(byAdding: .day, value: 1, to: today)!, 0]
//            )
//        } else if currentTab == .failed {
//            return NSPredicate(
//                format: "\(filterKey) >= %@ AND \(filterKey) < %@ AND isComplete == %i",
//                argumentArray: [calendar.startOfDay(for: Date()), Date.distantPast, 0]
//            )
//        } else if currentTab == .upcoming {
//            return NSPredicate(
//                format: "\(filterKey) >= %@ AND \(filterKey) < %@ AND isComplete == %i",
//                argumentArray: [calendar.startOfDay(for: calendar.date(byAdding: .day, value: 1, to: Date())!), Date.distantFuture, 0]
//            )
//        } else {
//            return NSPredicate(
//                format: "isComplete == %i",
//                argumentArray: [1]
//            )
//        }
    }
}
