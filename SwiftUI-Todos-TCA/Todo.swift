//
//  Todo.swift
//  SwiftUI-Todos-TCA
//
//  Created by bruno on 15/10/21.
//

import ComposableArchitecture
import Foundation

struct Todo: Equatable, Identifiable {
    var id: UUID
    @BindableState var description: String = ""
    var isComplete = false
}
