//
//  Constants.swift
//  Task Manager (iOS)
//
//  Created by Riza Mamedov on 08.02.2024.
//

import SwiftUI

public struct AppConstants {
    // MARK: App Tabs is a main constant of sorting and navigation
    static let appTabs: [AppTab] = [.today, .upcoming, .done, .failed]

    // MARK: task color that can be assigned to a task record in the coredata
    static let taskColors: [TaskColor] = [.yellow, .green, .blue, .orange, .purple, .red, .indigo, .teal]

    // MARK: task types that can be assigned to a task record in coredata
    static let taskTypes: [TaskTypes] = [.basic, .urgent, .important]

    static let defaultTaskColor: TaskColor = taskColors[0]
    static let defaultAppTab: AppTab = appTabs[0]
    static let defaultTaskType: TaskTypes = taskTypes[0]
    
    
    static let defaultTaskCardDate: Date = Date()
    static let defaultTaskCardTitle: String = ""
    static let defaultTaskCardType: String = ""
    
    static func textColor(_ taskColor: String?) -> Color {
        return defineColorBy(
            TaskColor(
                rawValue: taskColor ??
                AppConstants.defaultTaskColor.rawValue
            ) ?? AppConstants.defaultTaskColor
        )
    }
    
    static func iconColor(_ taskColor: String?) -> TaskColor {
        return TaskColor(rawValue: taskColor ?? self.defaultTaskColor.rawValue) ?? self.defaultTaskColor
    }
}
