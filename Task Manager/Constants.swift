//
//  Constants.swift
//  Task Manager (iOS)
//
//  Created by Riza Mamedov on 08.02.2024.
//

import SwiftUI

public struct AppConstants {
    // MARK: App Tabs is a main constant of sorting and navigation
    static let appTabs: [AppTab] = AppTab.allCases

    // MARK: task color that can be assigned to a task record in the coredata
    static let taskColors: [TaskColor] = TaskColor.allCases

    // MARK: task types that can be assigned to a task record in coredata
    static let taskTypes: [TaskTypes] = TaskTypes.allCases

    static let defaultAppTab: AppTab = appTabs[0]
    static let defaultTaskColor: TaskColor = taskColors[0]
    static let defaultTaskType: TaskTypes = taskTypes[0]
    static let defaultTaskDate: Date = Date()
    static let defaultTaskTitle: String = ""
    
    static func getTextColor(_ taskColor: String?) -> Color {
        return defineColorBy(
            TaskColor(
                rawValue: taskColor ??
                AppConstants.defaultTaskColor.rawValue
            ) ?? AppConstants.defaultTaskColor
        )
    }
    
    static func getIconColor(_ taskColor: String?) -> TaskColor {
        return TaskColor(rawValue: taskColor ?? self.defaultTaskColor.rawValue) ?? self.defaultTaskColor
    }
}
