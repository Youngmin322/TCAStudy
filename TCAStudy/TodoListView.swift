//
//  TodoListView.swift
//  TCAStudy
//
//  Created by Youngmin Cho on 3/2/26.
//

import SwiftUI
import ComposableArchitecture

struct TodoListView: View {
    @Bindable var store: StoreOf<TodoListFeature>
    
    var filteredTodos: [TodoItem] {
        switch store.filter {
        case .all:
            return Array(store.todos)
            
        case .active:
            return store.todos.filter{ !$0.isCompleted }
            
        case .completed:
            return store.todos.filter { $0.isCompleted }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Picker("필터", selection: $store.filter.sending(\.filterChanged)) {
                    ForEach(TodoListFeature.State.Filter.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                List {
                    ForEach(filteredTodos) { todo in
                        HStack {
                            Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(todo.isCompleted ? .green : .gray)
                                .onTapGesture {
                                    store.send(.todoToggled(id: todo.id))
                                }
                            
                            Text(todo.title)
                                .strikethrough(todo.isCompleted)
                                .foregroundColor(todo.isCompleted ? .secondary : .primary)
                        }
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            let id = filteredTodos[index].id
                            store.send(.todoDeleted(id: id))
                        }
                    }
                }
                
                HStack {
                    TextField("할 일 입력", text: $store.inputText.sending(\.inputTextChanged))
                        .textFieldStyle(.roundedBorder)
                    
                    Button {
                        store.send(.addButtonTapped)
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(12)
                            .background(Color.accentColor)
                            .clipShape(Circle())
                    }
                }
                .padding()
            }
            .navigationTitle("TCA Todo")
        }
    }
}

#Preview {
    TodoListView(
        store: Store(initialState: TodoListFeature.State()) {
            TodoListFeature()
        }
    )
}
