//
//  TodoCore.swift
//  SwiftUI-Todos-TCA
//
//  Created by bruno on 15/10/21.
//

import ComposableArchitecture

enum TodoAction: Equatable {
    case checkBoxTapped
    case textFieldChanged(String)
}

struct TodoEnvironment {
    
}

let todoReducer = Reducer<Todo, TodoAction, TodoEnvironment> { state, action, environment in
    switch action {
    case .checkBoxTapped:
        debugPrint("todoReducer: .checkBoxTapped")
        state.isComplete.toggle()
        return .none
    case .textFieldChanged(let text):
        debugPrint("todoReducer: .textFieldChanged")
        state.description = text
        return .none
    }
}
