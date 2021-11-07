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
                    ForEachStore(
                      store.scope(state: \.todos, action: AppAction.todo(id:action:)),
                      content: TodoView.init(store:)
                    )
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Todos")
                .toolbar {
                    Button(action: { viewStore.send(.addButtonTapped) }) {
                        Text("Add")
                    }
                }
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
                                 environment: AppEnvironment(mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
                                                             uuid: UUID.init)))
    }
}
