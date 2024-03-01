//
//  Types.swift
//  Task Manager
//
//  Created by Riza Mamedov on 09.02.2024.
//

import Foundation


public enum AppTab: String {
    case today = "Today"
    case upcoming = "Upcoming"
    case done = "Done"
    case failed = "Failed"
}

public enum TaskColor: String {
    case yellow = "Yellow"
    case green = "Green"
    case blue = "Blue"
    case purple = "Purple"
    case orange = "Orange"
    case red = "Red"
    case indigo = "Indigo"
    case teal = "Teal"
}

public enum TaskTypes: String {
    case basic = "Basic"
    case urgent = "Urgent"
    case important = "Important"
}
