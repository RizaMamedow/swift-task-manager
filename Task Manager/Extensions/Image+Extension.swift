//
//  Image+Extension.swift
//  Task Manager (iOS)
//
//  Created by Riza Mamedov on 09.03.2024.
//

import SwiftUI

extension Image {
    func imageColorBy(backgroundColor: TaskColor) -> some View {
        return self.foregroundColor(defineColorBy(backgroundColor))
    }
}
