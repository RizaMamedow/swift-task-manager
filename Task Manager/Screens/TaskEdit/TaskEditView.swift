//
//  TaskManipulation.swift
//  Task Manager (iOS)
//
//  Created by Riza Mamedov on 08.02.2024.
//

import SwiftUI

struct TaskEditView: View {
    @EnvironmentObject var viewModel: TaskEditViewModel
    @Environment(\.self) var env
    
    @Namespace private var animation
    
    var body: some View {
        VStack(spacing: 12) {
            header()
            
            taskColor()
            Divider()
                .padding(.vertical, 10)
            
            taskDate()
            Divider()
            
            taskTitle()
            Divider()
            
            taskType()
            Divider()
            
            saveButton {
                if viewModel.addTask(context: env.managedObjectContext) {
                    env.dismiss()
                    viewModel.toDefaults()
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        .overlay {
            ZStack {
                if viewModel.openDatePicker {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .ignoresSafeArea()
                        .onTapGesture{
                            viewModel.closeDatePicker()
                        }
                    
                    DatePicker.init("", selection: $viewModel.taskDeadline, in: Date.now...Date.distantFuture)
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                        .padding()
                        .background(.white, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .padding()
                }
            }
            .animation(.easeInOut, value: viewModel.openTaskEditScreen)
        }
    }
    
    @ViewBuilder
    func header() -> some View {
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
                    if let editTask = viewModel.editTask {
                        env.managedObjectContext.delete(editTask)
                        try? env.managedObjectContext.save()
                        env.dismiss()
                    }
                } label: {
                    Image(systemName: "trash")
                        .font(.title3)
                        .foregroundColor(.red)
                }
                .opacity(viewModel.trashButtonVisibility)
            }
    }
    
    @ViewBuilder
    func taskColor() -> some View {
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
                            if viewModel.taskColor == color {
                                Circle()
                                    .strokeBorder(.gray)
                                    .padding(-3)
                                    .matchedGeometryEffect(id: "COLOR", in: animation)
                            }
                        }
                        .contentShape(Circle())
                        .onTapGesture {
                            withAnimation { viewModel.taskColor = color }
                        }
                }
            }
            .padding(.top, 10)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 30)
    }
    
    @ViewBuilder
    func taskDate() -> some View {
        VStack(alignment: .leading, spacing: 12){
            Text("Task Date")
                .font(.caption)
                .foregroundColor(.gray)
            
            Text(viewModel.taskFormattedDeadline)
                .font(.callout)
                .fontWeight(.semibold)
                .padding(.top, 8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(alignment: .bottomTrailing) {
            Button {
                viewModel.openDatePicker.toggle()
            } label: {
                Image(systemName: "calendar")
                    .foregroundColor(.black)
            }
        }
    }
    
    @ViewBuilder
    func taskTitle() -> some View {
        VStack(alignment: .leading, spacing: 12){
            Text("Task Title")
                .font(.caption)
                .foregroundColor(.gray)
            
            TextField("", text: $viewModel.taskTitle)
                .frame(maxWidth: .infinity)
                .padding(.top, 10)
        }
        .padding(.top, 10)
    }
    
    @ViewBuilder
    func taskType() -> some View {
        VStack(alignment: .leading, spacing: 12){
            Text("Task Type")
                .font(.caption)
                .foregroundColor(.gray)
            
            HStack {
                ForEach(AppConstants.taskTypes, id: \.self) { taskType in
                    Text(taskType.value)
                        .font(.callout)
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(viewModel.taskType == taskType ? .white : .black)
                        .background{
                            if viewModel.taskType == taskType {
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
                            withAnimation{ viewModel.taskType = taskType }
                        }
                }
            }
            .padding(.top, 10)
        }
        .padding(.top, 10)
        
    }
    
    
    @ViewBuilder
    func saveButton(perform action: @escaping () -> Void) -> some View {
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
        .disabled(viewModel.isSaveButtonDisabled)
        .opacity(viewModel.isSaveButtonDisabled ? 0.6 : 1)
    }
}

struct NewTask_Previews: PreviewProvider {
    static var previews: some View {
        TaskEditView()
            .environmentObject(MainViewModel())
    }
}
