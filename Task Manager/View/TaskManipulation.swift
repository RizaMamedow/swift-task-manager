//
//  TaskManipulation.swift
//  Task Manager (iOS)
//
//  Created by Riza Mamedov on 08.02.2024.
//

import SwiftUI

struct TaskManipulationView: View {
    @EnvironmentObject var taskModel: TaskViewModel
    @Environment(\.self) var env
    
    @Namespace private var animation
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Task")
                .font(.title2.bold())
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading) {
                    Button {
                        env.dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title3)
                            .foregroundColor(.black)
                    }
                }
                .overlay(alignment: .trailing) {
                    Button {
                        if let editTask = taskModel.editTask {
                            env.managedObjectContext.delete(editTask)
                            try? env.managedObjectContext.save()
                            env.dismiss()
                        }
                    } label: {
                        Image(systemName: "trash")
                            .font(.title3)
                            .foregroundColor(.red)
                    }
                    .opacity(taskModel.editTask != nil ? 1 : 0)
                }
            VStack(alignment: .leading, spacing: 12){
                Text("Task Color")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                HStack(spacing: 15){
                    ForEach(AppConstants.taskColors, id: \.self) { color in
                        Circle()
                            .fill(Color(color.rawValue))
                            .frame(width: 25, height: 25)
                            .background{
                                if taskModel.taskColor == color {
                                    Circle()
                                        .strokeBorder(.gray)
                                        .padding(-3)
                                        .matchedGeometryEffect(id: "COLOR", in: animation)
                                }
                            }
                            .contentShape(Circle())
                            .onTapGesture {
                                withAnimation { taskModel.taskColor = color }
                            }
                    }
                }
                .padding(.top, 10)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 30)
            
            
            Divider()
                .padding(.vertical, 10)
            
            VStack(alignment: .leading, spacing: 12){
                Text("Task Date")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text(taskModel.taskDeadline.formatted(date: .abbreviated, time: .omitted) + "," + taskModel.taskDeadline.formatted(date: .omitted, time: .shortened))
                    .font(.callout)
                    .fontWeight(.semibold)
                    .padding(.top, 8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(alignment: .bottomTrailing) {
                Button {
                    taskModel.openDatePicker.toggle()
                } label: {
                    Image(systemName: "calendar")
                        .foregroundColor(.black)
                }
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 12){
                Text("Task Title")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                TextField("", text: $taskModel.taskTitle)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 10)
            }
            .padding(.top, 10)
            
            Divider()
            
            VStack(alignment: .leading, spacing: 12){
                Text("Task Type")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                HStack {
                    ForEach(AppConstants.taskTypes, id: \.self) { taskType in
                        Text(taskType.rawValue)
                            .font(.callout)
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(taskModel.taskType == taskType ? .white : .black)
                            .background{
                                if taskModel.taskType == taskType {
                                    Capsule()
                                        .fill(.black)
                                        .matchedGeometryEffect(id: "TYPE", in: animation)
                                } else {
                                    Capsule()
                                        .strokeBorder(.black)
                                }
                            }
                            .contentShape(Capsule())
                            .onTapGesture {
                                withAnimation{ taskModel.taskType = taskType }
                            }
                    }
                }
                .padding(.top, 10)
            }
            .padding(.top, 10)
            
            Divider()
            
            SaveButton {
                if taskModel.addTask(context: env.managedObjectContext) {
                    env.dismiss()
                    taskModel.toDefaults()
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        .overlay {
            ZStack {
                if taskModel.openDatePicker {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .ignoresSafeArea()
                        .onTapGesture{
                            taskModel.openDatePicker = false
                        }
                    
                    DatePicker.init("", selection: $taskModel.taskDeadline, in: Date.now...Date.distantFuture)
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                        .padding()
                        .background(.white, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .padding()
                }
            }
            .animation(.easeInOut, value: taskModel.openTaskManipulateScreen)
        }
    }
    
    
    @ViewBuilder
    func SaveButton(perform action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Text("Save")
                .font(.callout)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding()
                .background{
                    Capsule()
                        .fill(.black)
                }
                .foregroundColor(.white)
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding(.bottom, 10)
        .disabled(taskModel.taskTitle == "")
        .opacity(taskModel.taskTitle == "" ? 0.6 : 1)
    }
}

struct NewTask_Previews: PreviewProvider {
    static var previews: some View {
        TaskManipulationView()
            .environmentObject(TaskViewModel())
    }
}
