//
//  ContentView.swift
//  SwiftUI-Todos-TCA
//
//  Created by bruno on 14/10/21.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    
    let store: Store<AppState, AppAction>
    
    var body: some View {
        NavigationView {
            WithViewStore(store) { viewStore in
                List {
                    ForEach(Array(viewStore.todos.enumerated()), id: \.element.id) { index, todo in
                        HStack {
                            Button(action: { viewStore.send(.todo(index: index, action: .checkBoxTapped)) }) {
                                Image(systemName: todo.isComplete ? "checkmark.square" : "square")
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            TextField("Untitled todo",
                                      text: viewStore.binding(
                                        get: { $0.todos[index].description },
                                        send: { .todo(index: index, action: .textFieldChanged($0)) }
                                      )
                            )
                        }
                        .foregroundColor(todo.isComplete ? .gray : nil)
                    }
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Todos")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store: Store(initialState: AppState(todos: [
            Todo(
                id: UUID(),
                description: "Milk",
                isComplete: false
            ),
            Todo(
                id: UUID(),
                description: "Eggs",
                isComplete: false
            ),
            Todo(
                id: UUID(),
                description: "Hand Soap",
                isComplete: true
            ),
        ]),
                                 reducer: appReducer,
                                 environment: AppEnvironment()))
    }
}
