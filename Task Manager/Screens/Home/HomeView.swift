//
//  Home.swift
//  Task Manager (iOS)
//
//  Created by Riza Mamedov on 08.02.2024.
//

import SwiftUI

// MARK: Home View
struct HomeView: View {
    @ObservedObject var viewModel: MainViewModel = .init()
    
    @Namespace var animation
    
    // MARK: Fetch request to get all tasks
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Task.deadline, ascending: false)],
        predicate: nil,
        animation: .easeInOut
    ) var tasks: FetchedResults<Task>
    
    @Environment(\.self) var env
    @State var refresh: Bool = false

    
    var body: some View {
        // MARK: Main View
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("You're there!")
                        .font(.callout)
                    Text("Updates is here")
                        .font(.title2.bold())
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical)
                
                tabBar()
                    .padding(.top, 5)

                taskView()
            }
            .padding()
        }
        // MARK: Add button
        .overlay(alignment: .bottom) {
            Button{
                viewModel.openTaskEditScreen.toggle()
            } label: {
                Label {
                    Text("Add Task")
                        .font(.callout)
                        .fontWeight(.semibold)
                } icon: {
                    Image(systemName: "plus.app.fill")
                }
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(.black, in: Capsule())
            }
            .padding(.top, 10)
            .padding(.bottom, 10)
            .frame(maxWidth: .infinity)
            .background{
                LinearGradient(colors: [
                    .white.opacity(0.05),
                    .white.opacity(0.4),
                    .white.opacity(0.7),
                ], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
            }

        }
        // Task Manipulate
        .fullScreenCover(isPresented: $viewModel.openTaskEditScreen) {
            viewModel.toDefaults()
        } content: {
            TaskEditView()
                .environmentObject(TaskEditViewModel.init(appViewModel: viewModel))
        }
    }
    
    @ViewBuilder
    func taskView() -> some View {
        LazyVStack(spacing: 20){
            DynamicFilteredView(viewModel: .init(appViewModel: viewModel)) { (task: Task) in
                TaskCardView(task: task)
                    .environmentObject(TaskCardViewModel.init(appViewModel: viewModel, task: task))
            }
        }
        .padding(.top, 20)
    }
    
    @ViewBuilder
    func tabBar() -> some View {
        HStack(spacing: 10) {
            ForEach(AppConstants.appTabs, id: \.self){ tab in
                Text(tab.value)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .scaleEffect(0.9)
                    .foregroundColor(viewModel.currentTab == tab ? .white : .black)
                    .padding(.vertical, 6)
                    .frame(maxWidth: .infinity)
                    .background {
                        if viewModel.currentTab == tab {
                            Capsule()
                                .fill(.black)
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        }
                    }
                    .contentShape(Capsule())
                    .onTapGesture {
                        withAnimation {
                            viewModel.currentTab = tab
                            
                        }
                    }
            }
        }
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
