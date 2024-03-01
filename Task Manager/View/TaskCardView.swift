//
//  TaskCardView.swift
//  Task Manager
//
//  Created by Riza Mamedov on 10.02.2024.
//

import SwiftUI

// MARK: Task Card View
struct TaskCardView: View {
    // MARK: ObservedObject is required
    @ObservedObject var task: Task
    @EnvironmentObject var taskModel: TaskViewModel
    @Environment(\.self) var env
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            HStack {
                // MARK: Task type text
                Text(task.type ?? AppConstants.defaultTaskCardTitle)
                    .font(.callout)
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .background{
                        Capsule()
                            .fill(.ultraThinMaterial)
                    }
                    .foregroundColor(AppConstants.textColor(task.color))
                
                Spacer()
                
                // MARK: Task edit button
                if !task.isComplete || taskModel.currentTab != .failed {
                    Button {
                        taskModel.editTask = task
                        taskModel.openTaskManipulateScreen = true
                        taskModel.setupTask()
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .imageColorBy(backgroundColor: AppConstants.iconColor(task.color))
                    }
                }
            }
            
            // MARK: Task title text
            Text(task.title ?? AppConstants.defaultTaskCardTitle)
                .font(.title2.bold())
                .padding(.vertical, 10)
                .foregroundColor(AppConstants.textColor(task.color))
            
            // MARK: Task datetime labels
            HStack(alignment: .bottom, spacing: 0) {
                VStack(alignment: .leading, spacing: 10) {
                    Label {
                        Text((task.deadline ?? AppConstants.defaultTaskCardDate).formatted(date: .long, time: .omitted))
                            .foregroundColor(AppConstants.textColor(task.color))
                    } icon: {
                        Image(systemName: "calendar")
                            .imageColorBy(backgroundColor: AppConstants.iconColor(task.color))
                    }
                    .font(.caption)
                    
                    Label {
                        Text((task.deadline ?? AppConstants.defaultTaskCardDate).formatted(date: .omitted, time: .shortened))
                            .foregroundColor(AppConstants.textColor(task.color))
                    } icon: {
                        Image(systemName: "clock")
                            .imageColorBy(backgroundColor: AppConstants.iconColor(task.color))
                    }
                    .font(.caption)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // MARK: Task complete/uncomplete button
                if !task.isComplete || taskModel.currentTab != .failed {
                    Button {
                        withAnimation {
                            taskModel.toggleTaskStatus(task, context: env.managedObjectContext)
                        }
                    } label: {
                        let shapeColor = AppConstants.textColor(task.color)
                        
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
