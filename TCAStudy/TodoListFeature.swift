//
//  TodoListFeature.swift
//  TCAStudy
//
//  Created by Youngmin Cho on 3/2/26.
//

import Foundation
import ComposableArchitecture

@Reducer
struct TodoListFeature {
    @ObservableState
    struct State: Equatable {
        var todos: IdentifiedArrayOf<TodoRowFeature.State> = []
        var inputText: String = ""
        var filter: Filter = .all
        
        enum Filter: String, CaseIterable, Equatable {
            case all = "전체"
            case active = "진행 중"
            case completed = "완료"
        }
    }
    
    @Dependency(\.uuid) var uuidGenerator
    
    enum Action {
        case inputTextChanged(String) // 텍스트 필드
        case addButtonTapped // 추가 버튼 탭
        case filterChanged(State.Filter) // 필터 변경
        case todos(IdentifiedActionOf<TodoRowFeature>)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
                
            case let .inputTextChanged(text):
                state.inputText = text
                return .none

                
            case .addButtonTapped:
                // 빈 문자열이면 무시
                guard !state.inputText.trimmingCharacters(in: .whitespaces).isEmpty
                else { return .none }
                
                // 새 Todo 만들어서 배열에 추가
                let newTodo = TodoRowFeature.State(
                    id: self.uuidGenerator(),
                    title: state.inputText,
                    isCompleted: false
                )
                state.todos.append(newTodo)
                state.inputText = ""  // 입력창 초기화
                return .none
                
            case let .todos(.element(id: id, action: .deleteTapped)):
                state.todos.remove(id: id)
                return .none
                
            case .todos:
                return .none
                
            case let .filterChanged(filter):
                state.filter = filter
                return .none
            }
        }
        .forEach(\.todos, action: \.todos) {
            TodoRowFeature()
        }
    }
}
