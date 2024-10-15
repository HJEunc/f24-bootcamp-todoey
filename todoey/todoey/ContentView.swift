//
//  ContentView.swift
//  todoey
//
//  Created by Harrison Enyeart on 10/15/24.
//

import SwiftUI

struct Todo: Identifiable {
    let id = UUID()
    var isDone = false
    var text: String
}

extension Todo {
    static var example: Todo {
        Todo(text: "Walk the dog")
    }
    static var exampleList: [Todo] {
        [Todo(text: "Walk the dog"), Todo(text: "Feed the hog"), Todo(isDone: true, text: "Eat breakfast")]
    }
}

struct TodoRowView: View {
    @State var todo: Todo
    let color: Color
    var body: some View {
        HStack {
            Button {
                todo.isDone.toggle()
            } label: {
                Image(systemName: todo.isDone ? "checkmark.square.fill" : "square")
            }
            .foregroundStyle(color)
            TextField("", text: $todo.text)
        }
    }
}

#Preview {
    TodoRowView(todo: .example, color: .purple)
}

struct TodoListView: View {
    @State private var todoList = Todo.exampleList
    let color: Color
    var body: some View {
        List {
            ForEach(todoList) { todo in
                TodoRowView(todo: todo, color: color)
            }
        }
        .listStyle(.plain)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text("Todoey")
                    .font(.largeTitle)
                    .bold()
                    .fontDesign(.rounded)
                    .foregroundStyle(color)
            }
            ToolbarItem(placement: .bottomBar) {
                HStack {
                    Button {
                        todoList.append(Todo(text: ""))
                    } label: {
                        Image(systemName: "plus.circle.fill")
                        Text("New Todo")
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(color)
                    .fontDesign(.rounded)
                    .bold()
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        TodoListView(color: .purple)
    }
}

struct ParentTodoListView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Homework") {
                    TodoListView(color: .red)
                }
                .foregroundStyle(.red)
                NavigationLink("Chores") {
                    TodoListView(color: .purple)
                }
                .foregroundStyle(.purple)
            }
            .navigationTitle("Reminders")
        }
    }
}

#Preview {
    ParentTodoListView()
}

struct ContentView: View {
    var body: some View {
        VStack {
            
        }
    }
}

#Preview {
    ContentView()
}
