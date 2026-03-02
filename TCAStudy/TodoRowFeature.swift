//
//  TodoRowFeature.swift
//  TCAStudy
//
//  Created by Youngmin Cho on 3/2/26.
//

import Foundation
import ComposableArchitecture

@Reducer
struct TodoRowFeature {
    @ObservableState
    struct State: Equatable, Identifiable {
        let id: UUID
        var title: String
        var isCompleted: Bool
    }
    
    enum Action {
        case toggleTapped
        case deleteTapped
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .toggleTapped:
                state.isCompleted.toggle()
                return .none
                
            case .deleteTapped:
                return .none
            }
        }
    }
}
