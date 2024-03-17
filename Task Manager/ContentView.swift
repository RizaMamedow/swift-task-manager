//
//  ContentView.swift
//  Task Manager
//
//  Created by Riza Mamedov on 08.02.2024.
//

import SwiftUI

// MARK: Main view of app
struct ContentView: View {
    var body: some View {
        NavigationView{
            HomeView()
                // MARK: Title
                .navigationTitle("Task Manager")
                // MARK: Title style
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: Main app preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
