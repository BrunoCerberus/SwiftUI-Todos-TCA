//
//  MainCore.swift
//  SwiftUI-Todos-TCA
//
//  Created by bruno on 14/10/21.
//

import ComposableArchitecture

struct AppState: Equatable {
    var todos: [Todo] = []
}

enum AppAction: Equatable {
    case addButtonTapped
    case todo(index: Int, action: TodoAction)
//    case todoCheckboxTapped(index: Int)
//    case todoTextFieldChanged(index: Int, text: String)
}

struct AppEnvironment {
    var uuid: () -> UUID
}

//let appReducer: Reducer<AppState, AppAction, AppEnvironment> = todoReducer.forEach(
//    state: \AppState.todos,
//    action: /AppAction.todo(index:action:),
//    environment: { _ in TodoEnvironment() }
//)
//.debug()

//    Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
//    switch action {
//    case .todoCheckboxTapped(index: let index):
//        state.todos[index].isComplete.toggle()
//        return .none
//    case .todoTextFieldChanged(index: let index, text: let text):
//        state.todos[index].description = text
//        return .none
//    }
//}
//.debug()

let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine(
    todoReducer.forEach(state: \.todos,
                        action: /AppAction.todo(index:action:),
                        environment: { _ in TodoEnvironment() }),
        Reducer { state, action, environment in
            switch action {
            case .todo(index: _, action: .checkBoxTapped):
                state.todos = state.todos
                    .enumerated()
                    .sorted { lhs, rhs in
                        (!lhs.element.isComplete && rhs.element.isComplete)
                        || lhs.offset < rhs.offset
                    }
                    .map(\.element)
                return .none
                
            case .addButtonTapped:
                state.todos.insert(Todo(id: environment.uuid()), at: 0)
                return .none
            case .todo(index: let index, action: .textFieldChanged(_)):
                return .none
            }
        }
)
