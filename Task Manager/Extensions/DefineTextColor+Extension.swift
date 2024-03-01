//
//  DefineTextColor.swift
//  Task Manager (iOS)
//
//  Created by Riza Mamedov on 08.02.2024.
//

import SwiftUI

public func defineColorBy(_ backgroundColor: TaskColor) -> Color {
    if backgroundColor.rawValue.lowercased() == TaskColor.yellow.rawValue.lowercased() {
        return .black
    } else {
        return .white
    }
}

extension Image {
    func imageColorBy(backgroundColor: TaskColor) -> some View {
        return self.foregroundColor(defineColorBy(backgroundColor))
    }
}
