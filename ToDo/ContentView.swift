//
//  ContentView.swift
//  ToDo
//
//  Created by Big Guy on 11/17/25.
//

import SwiftUI

struct ContentView: View {
    @State private var tasks: [Task] = [
        Task(title: "Buy milk"),
        Task(title: "Walk the dog"),
        Task(title: "Study Swift"),
        Task(title: "Watch football")
    ]
    
    struct Task: Identifiable {
        let id = UUID()
        var title: String
        var isCompleted: Bool
        
        
        init (title: String, isCompleted: Bool = false) {
            self.title = title
            self.isCompleted = isCompleted
        }
    }
    
    var body: some View {
        Text("My To-Do List!")
            .bold()
        
        List($tasks) { $task in
            HStack {
                Button {
                    task.isCompleted.toggle()
                } label: {
                    Circle()
                        .fill(task.isCompleted ? Color.green : Color.gray)
                        .frame(width: 20, height: 20)
                }
                Text(task.title)
                    .strikethrough(task.isCompleted)
            }
        }
    }
}

#Preview {
    ContentView()
}
