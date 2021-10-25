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
        let store = TestStore(initialState: AppState(),
                              reducer: appReducer,
                              environment: AppEnvironment())
    }
}
