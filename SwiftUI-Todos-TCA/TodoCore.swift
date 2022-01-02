//
//  TodoCore.swift
//  SwiftUI-Todos-TCA
//
//  Created by bruno on 15/10/21.
//

import ComposableArchitecture

enum TodoAction: Equatable, BindableAction {
    case binding(BindingAction<Todo>)
        
    case checkBoxTapped
}

struct TodoEnvironment {}

let todoReducer = Reducer<Todo, TodoAction, TodoEnvironment> { state, action, environment in
    switch action {
    case .checkBoxTapped:
        debugPrint("todoReducer: .checkBoxTapped")
        state.isComplete.toggle()
        return .none
    case .binding:
        debugPrint("TEXT CHANGED ON todoReducer")
        return .none
    }
}
.binding()
.debug()
