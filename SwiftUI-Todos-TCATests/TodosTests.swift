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
    
    let scheduler: TestSchedulerOf<DispatchQueue> = DispatchQueue.test
    
    func testCompletingTodo() {
        
        let appState = AppState(todos: [
            Todo(
                id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!,
                description: "Milk",
                isComplete: false
            )
        ]
                              )
        let store = TestStore(
            initialState: appState,
            reducer: appReducer,
            environment: AppEnvironment(mainQueue: scheduler.eraseToAnyScheduler(),
                                        uuid: { UUID(uuidString: "DEADBEEF-DEAD-BEEF-DEAD-BEEFDEADBEEF")! })
        )
        
        store.assert(
            .send(.todo(id: appState.todos[0].id, action: .checkBoxTapped)) {
                $0.todos[id: appState.todos[0].id]?.isComplete = true
            },
            .do {
//                _ = XCTWaiter.wait(for: [self.expectation(description: "wait")], timeout: 1)
                self.scheduler.advance(by: 1)
            },
            .receive(.todoDelayCompleted)
        )
    }
    
    func testAddTodo() {
        let store = TestStore(
            initialState: AppState(),
            reducer: appReducer,
            environment: AppEnvironment(
                mainQueue: scheduler.eraseToAnyScheduler(),
                uuid: { UUID(uuidString: "DEADBEEF-DEAD-BEEF-DEAD-BEEFDEADBEEF")! }
            )
        )
        
        store.assert(
            .send(.addButtonTapped) {
                $0.todos = [
                    Todo(
                        id: store.environment.uuid(),
                        description: "",
                        isComplete: false
                    )
                ]
            }
        )
    }
    
    func testTodoSorting() {
        
        let appState = AppState(todos: [
            Todo(
                id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!,
                description: "Milk",
                isComplete: false
            ),
            
            Todo(
                id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!,
                description: "Eggs",
                isComplete: false
            )
        ]
                              )
        let store = TestStore(
            initialState: appState,
            reducer: appReducer,
            environment: AppEnvironment(mainQueue: scheduler.eraseToAnyScheduler(),
                                        uuid: { fatalError("Uninplemented") })
        )
        
        store.assert(
            .send(.todo(id: appState.todos[0].id, action: .checkBoxTapped)) {
                $0.todos[id: appState.todos[0].id]?.isComplete = true
            },
            .do {
//                _ = XCTWaiter.wait(for: [self.expectation(description: "wait")], timeout: 1)
                self.scheduler.advance(by: 1)
            },
            .receive(.todoDelayCompleted) {
                $0.todos.swapAt(0, 1)
            }
        )
    }
    
    func testTodoSortingCancellation() {
        
        let appState = AppState(todos: [
            Todo(
                id: UUID(uuidString: "00000000-0000-0000-0000-000000000000")!,
                description: "Milk",
                isComplete: false
            ),
            
            Todo(
                id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!,
                description: "Eggs",
                isComplete: false
            )
        ]
                              )
        let store = TestStore(
            initialState: appState,
            reducer: appReducer,
            environment: AppEnvironment(mainQueue: scheduler.eraseToAnyScheduler(),
                                        uuid: { fatalError("Uninplemented") })
        )
        
        store.assert(
            .send(.todo(id: appState.todos[0].id, action: .checkBoxTapped)) {
                $0.todos[id: appState.todos[0].id]?.isComplete = true
            },
            .do {
//                _ = XCTWaiter.wait(for: [self.expectation(description: "wait")], timeout: 0.5)
                self.scheduler.advance(by: 0.5)
            },
            .send(.todo(id: appState.todos[0].id, action: .checkBoxTapped)) {
                $0.todos[id: appState.todos[0].id]?.isComplete = false
            },
            .do {
//                _ = XCTWaiter.wait(for: [self.expectation(description: "wait")], timeout: 1)
                self.scheduler.advance(by: 1)
            },
            .receive(.todoDelayCompleted)
        )
    }
}
