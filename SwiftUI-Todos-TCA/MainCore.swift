//
//  MainCore.swift
//  SwiftUI-Todos-TCA
//
//  Created by bruno on 14/10/21.
//

import ComposableArchitecture

struct AppState: Equatable {
    var todos: IdentifiedArrayOf<Todo> = []
}

enum AppAction: Equatable {
    case addButtonTapped
    case todo(id: Todo.ID, action: TodoAction)
    case todoDelayCompleted
}

struct AppEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue>
    var uuid: () -> UUID
}

let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine(
    todoReducer.forEach(
      state: \.todos,
      action: /AppAction.todo(id:action:),
      environment: { _ in TodoEnvironment() }
    ),
        Reducer { state, action, environment in
            switch action {
            case .todo(id: _, action: .checkBoxTapped):
                debugPrint("appReducer: .checkBoxTapped")
                struct CancelDelayId: Hashable {}
                return Effect(value: AppAction.todoDelayCompleted)
                    .delay(for: 1, scheduler: environment.mainQueue.animation())
                    .eraseToEffect()
                    .cancellable(id: CancelDelayId(), cancelInFlight: true)
            case .addButtonTapped:
                state.todos.insert(Todo(id: environment.uuid()), at: 0)
                return .none
            case .todo(id: _, action: .textFieldChanged(_)):
                debugPrint("appReducer: .textFieldChanged")
                return .none
            case .todo:
                return .none
            case .todoDelayCompleted:
                state.todos = IdentifiedArrayOf(uniqueElements: state.todos
                    .enumerated()
                    .sorted { lhs, rhs in
                        (!lhs.element.isComplete && rhs.element.isComplete)
                        || lhs.offset < rhs.offset
                    }
                    .map(\.element))
                return .none
            }
        }
)
