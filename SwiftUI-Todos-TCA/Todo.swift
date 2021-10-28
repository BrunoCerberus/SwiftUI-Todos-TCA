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
