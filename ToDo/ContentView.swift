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
    @State private var completedNum: Int = 0
    
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
                    if task.isCompleted {
                        completedNum -= 1
                    } else {
                        completedNum += 1
                    }
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
        
        Text("Completed: \(completedNum)")
    }
}

#Preview {
    ContentView()
}
