//
//  TodosTests.swift
//  SwiftUI-Todos-TCATests
//
//  Created by bruno on 24/10/21.
//

import ComposableArchitecture
import XCTest
@testable import SwiftUI_Todos_TCA

final class TodosTests: XCTestCase {
    
    func testCompletingTodo() {
        let store = TestStore(
            initialState: AppState(todos: [
                Todo(
                    id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!,
                    description: "Milk",
                    isComplete: false
                )
            ]
                                  ),
            reducer: appReducer,
            environment: AppEnvironment()
        )
        
        store.assert(
            .send(.todo(index: 0, action: .checkBoxTapped)) {
                $0.todos[0].isComplete = true
            }
        )
    }
}
