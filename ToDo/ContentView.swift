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
    @State private var newTaskTitle: String = ""
    @State private var isAddingNewTask: Bool = false


    struct Task: Identifiable {
        let id = UUID()
        var title: String
        var isCompleted: Bool = false
    }

    // Delete function updates completedNum if needed
    func deleteTask(at offsets: IndexSet) {
        for index in offsets {
            if tasks[index].isCompleted {
                completedNum -= 1
            }
        }
        tasks.remove(atOffsets: offsets)
    }
    
    func addTask() {
        let trimmed = newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        
        tasks.append(Task(title: trimmed))
        newTaskTitle = ""
        isAddingNewTask = false
    }

    var body: some View {
        VStack {
            Text("My To-Do List!")
                .font(.largeTitle)
                .bold()
                .padding()

            List {
                ForEach($tasks) { $task in
                    HStack {
                        // Task toggle button
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

                        // Task name
                        Text(task.title)
                            .strikethrough(task.isCompleted)
                        
                        Spacer()
                    }
                }
                .onDelete(perform: deleteTask) // Swipe-to-delete

                // New task row
                if isAddingNewTask {
                    HStack {
                        TextField("New task", text: $newTaskTitle)
                            .textFieldStyle(.plain)
                        
                        Button {
                            addTask()
                        } label: {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                } else {
                    Button {
                        isAddingNewTask = true
                    } label: {
                        HStack {
                            Spacer()
                            Image(systemName: "plus")
                                .foregroundColor(.green)
                            Spacer()
                        }
                    }
                }
            }

            Text("Completed: \(completedNum)")
                .padding()
        }
    }
}

#Preview {
    ContentView()
}

