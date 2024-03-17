//
//  CommonTypes.swift
//  Task Manager
//
//  Created by Riza Mamedov on 10.03.2024.
//

import Foundation


public enum TaskTypes: String, CaseIterable {
    case basic, important, urgent
    
    var value: String {
        return self.rawValue.capitalized
    }
}

public enum AppTab: String, CaseIterable {
    case today, upcoming, done, failed
    
    var value: String {
        return self.rawValue.capitalized
    }
}

public enum TaskColor: String, CaseIterable {
    case yellow, green, blue, purple, orange, red, indigo, teal
    
    var value: String {
        return self.rawValue.capitalized
    }
}
