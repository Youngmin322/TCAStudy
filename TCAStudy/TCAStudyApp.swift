//
//  TCAStudyApp.swift
//  TCAStudy
//
//  Created by Youngmin Cho on 3/2/26.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCAStudyApp: App {
    var body: some Scene {
        WindowGroup {
            TodoListView(
                store: Store(initialState: TodoListFeature.State()) {
                    TodoListFeature()
                }
            )
        }
    }
}
