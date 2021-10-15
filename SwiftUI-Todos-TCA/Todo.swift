//
//  Todo.swift
//  SwiftUI-Todos-TCA
//
//  Created by bruno on 15/10/21.
//

import Foundation

struct Todo: Equatable, Identifiable {
    var id: UUID = UUID()
    var description = ""
    var isComplete = false
}
