//
//  SwiftUI_Todos_TCAApp.swift
//  SwiftUI-Todos-TCA
//
//  Created by bruno on 14/10/21.
//

import SwiftUI
import ComposableArchitecture

@main
struct SwiftUI_Todos_TCAApp: App {
    var body: some Scene {
        WindowGroup {
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
}
