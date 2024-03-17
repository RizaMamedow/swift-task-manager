//
//  ViewModelsType.swift
//  Task Manager
//
//  Created by Riza Mamedov on 10.03.2024.
//

import SwiftUI

@MainActor
protocol ViewModelsType: ObservableObject {
    var currentTab: AppTab { get set }
    
    var openTaskEditScreen: Bool { get set }
    var taskTitle: String { get set }
    var taskColor: TaskColor { get set }
    var taskDeadline: Date { get set }
    var taskType: TaskTypes { get set }
    
    var editTask: Task? { get set }
    
    func toDefaults() -> Void
}
