//
//  DynamicFilteredView.swift
//  Task Manager (iOS)
//
//  Created by Riza Mamedov on 08.02.2024.
//

import SwiftUI
import CoreData

struct DynamicFilteredView<Content: View, T>: View where T: NSManagedObject {
    @FetchRequest var request: FetchedResults<T>
    var content: (T) -> Content
    
    init(
        predicate: NSPredicate,
        @ViewBuilder _ content: @escaping (T) -> Content
    ) {
        _request = FetchRequest(entity: T.entity(), sortDescriptors: [.init(keyPath: \Task.deadline, ascending: false)], predicate: predicate)
        
        self.content = content
    }
    
    var body: some View {
        Group {
            if self.request.isEmpty {
                VStack {
                    Label{
                        Text("No Task!")
                            .font(.system(size: 16))
                            .fontWeight(.light)
                    } icon: {
                        Image(systemName: "minus.circle")
                    }
                }
                .frame(maxHeight: .infinity)
                .offset(y: 100)
            }
            else {
                ForEach(request, id: \.objectID) { object in
                    self.content(object)
                }
            }
        }
    }
}

struct DynamicFilteredView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
