//
//  TaskCardView.swift
//  Task Manager
//
//  Created by Riza Mamedov on 10.02.2024.
//

import SwiftUI

// MARK: Task Card View
struct TaskCardView: View {
    @ObservedObject var task: Task
    @EnvironmentObject var viewModel: TaskCardViewModel
    @Environment(\.self) var env
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            HStack {
                // MARK: Task type text
                Text(task.type?.capitalized ?? AppConstants.defaultTaskTitle)
                    .font(.callout)
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .background{
                        Capsule()
                            .fill(.ultraThinMaterial)
                    }
                    .foregroundColor(AppConstants.getTextColor(task.color))
                
                Spacer()
                
                // MARK: Task edit button
                if !task.isComplete || viewModel.currentTab != .failed {
                    Button {
                        viewModel.openTaskScreen(task: task)
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .imageColorBy(backgroundColor: AppConstants.getIconColor(task.color))
                    }
                }
            }
            
            // MARK: Task title text
            Text(task.title ?? AppConstants.defaultTaskTitle)
                .font(.title2.bold())
                .padding(.vertical, 10)
                .foregroundColor(AppConstants.getTextColor(task.color))
            
            // MARK: Task datetime labels
            HStack(alignment: .bottom, spacing: 0) {
                VStack(alignment: .leading, spacing: 10) {
                    Label {
                        Text((task.deadline ?? AppConstants.defaultTaskDate).formatted(date: .long, time: .omitted))
                            .foregroundColor(AppConstants.getTextColor(task.color))
                    } icon: {
                        Image(systemName: "calendar")
                            .imageColorBy(backgroundColor: AppConstants.getIconColor(task.color))
                    }
                    .font(.caption)
                    
                    Label {
                        Text((task.deadline ?? AppConstants.defaultTaskDate).formatted(date: .omitted, time: .shortened))
                            .foregroundColor(AppConstants.getTextColor(task.color))
                    } icon: {
                        Image(systemName: "clock")
                            .imageColorBy(backgroundColor: AppConstants.getIconColor(task.color))
                    }
                    .font(.caption)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // MARK: Task complete/uncomplete button
                if !task.isComplete || viewModel.currentTab != .failed {
                    Button {
                        withAnimation {
                            viewModel.toggleTaskStatus(task, context: env.managedObjectContext)
                        }
                    } label: {
                        let shapeColor = AppConstants.getTextColor(task.color)
                        
                        Circle()
                            .strokeBorder(shapeColor, lineWidth: 1.5)
                            .frame(width: 25, height: 25)
                            .contentShape(Circle())
                            .background{
                                if task.isComplete {
                                        Circle()
                                            .fill(shapeColor)
                                            .frame(width: 15, height: 15)
                                }
                            }
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background{
            // MARK: Task card background
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color(task.color ?? AppConstants.defaultTaskColor.rawValue))
        }
    }
}
