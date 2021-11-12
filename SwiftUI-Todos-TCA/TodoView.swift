//
//  TodoView.swift
//  SwiftUI-Todos-TCA
//
//  Created by bruno on 06/11/21.
//

import SwiftUI
import ComposableArchitecture

struct TodoView : View {
    
    let store: Store<Todo, TodoAction>
    
    var body: some View {
        WithViewStore(store) { todoViewStore in
            HStack {
                Button(action: { todoViewStore.send(.checkBoxTapped) }) {
                    Image(systemName: todoViewStore.isComplete ? "checkmark.square" : "square")
                }
                .buttonStyle(PlainButtonStyle())
                
//                TextField("Untitled todo",
//                          text: todoViewStore.binding(
//                            get: \.description,
//                            send: TodoAction.textFieldChanged
//                          )
                TextField(
                    "Untitled todo",
                    text: todoViewStore.binding(\.$description)
                )
            }
            .foregroundColor(todoViewStore.isComplete ? .gray : nil)
        }
    }
}
