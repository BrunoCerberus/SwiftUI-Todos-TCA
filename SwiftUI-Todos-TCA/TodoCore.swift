//
//  TodoCore.swift
//  SwiftUI-Todos-TCA
//
//  Created by bruno on 15/10/21.
//

import ComposableArchitecture

enum TodoAction {
    case checkBoxTapped
    case textFieldChanged(String)
}

struct TodoEnvironment {
    
}

let todoReducer = Reducer<Todo, TodoAction, TodoEnvironment> { state, action, environment in
    switch action {
    case .checkBoxTapped:
        state.isComplete.toggle()
        return .none
    case .textFieldChanged(let text):
        state.description = text
        return .none
    }
}
