//
//  TodoItem.swift
//  TCAStudy
//
//  Created by Youngmin Cho on 3/2/26.
//

import Foundation

struct TodoItem: Equatable, Identifiable {
    let id: UUID
    let title: String
    let isCompleted: Bool = false
}
