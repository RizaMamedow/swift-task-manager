//
//  Color+Extension.swift
//  Task Manager
//
//  Created by Riza Mamedov on 09.03.2024.
//

import SwiftUI

public func defineColorBy(_ backgroundColor: TaskColor) -> Color {
    if backgroundColor.rawValue.lowercased() == TaskColor.yellow.rawValue.lowercased() {
        return .black
    } else {
        return .white
    }
}

