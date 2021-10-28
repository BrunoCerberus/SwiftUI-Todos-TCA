//
//  Todo.swift
//  SwiftUI-Todos-TCA
//
//  Created by bruno on 15/10/21.
//

import ComposableArchitecture
import Foundation

struct Todo: Equatable, Identifiable {
    let id: UUID
    var description = ""
    var isComplete = false
}

extension IdentifiedArray where ID == Todo.ID, Element == Todo {
    static let mock: Self = [
        Todo(
            id: UUID(uuidString: "DEADBEEF-DEAD-BEEF-DEAD-BEEDDEADBEEF")!,
            description: "Check Mail",
            isComplete: false
        ),
        Todo(
            id: UUID(uuidString: "CAFEBEEF-CAFE-BEEF-CAFE-BEEFCAFEBEEF")!,
            description: "Buy Milk",
            isComplete: false
        ),
        Todo(
            id: UUID(uuidString: "D00DCAFE-D00D-CAFE-D00D-CAFED00DCAFE")!,
            description: "Call Mom",
            isComplete: true
        ),
    ]
}
