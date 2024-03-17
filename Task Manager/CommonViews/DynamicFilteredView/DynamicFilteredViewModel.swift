//
//  DynamicFilteredViewModel.swift
//  Task Manager
//
//  Created by Riza Mamedov on 12.03.2024.
//

import Foundation
import CoreData

@MainActor
class DynamicFilteredViewModel: ObservableObject {
    @Published private var appViewModel: MainViewModel
    
    init(appViewModel: MainViewModel) {
        self.appViewModel = appViewModel
    }
    
    func getDynamicPredicate() -> NSPredicate {
        let calendar = Calendar.current
        let filterKey = "deadline"
        
        switch appViewModel.currentTab {
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
    }
}
