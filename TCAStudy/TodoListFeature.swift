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
    
    struct State: Equatable {
        var todos: IdentifiedArrayOf<TodoItem> = []
        var inputText: String = ""
        var filter: Filter = .all
        
        enum Filter: String, CaseIterable, Equatable {
            case all = "전체"
            case active = "진행 중"
            case completed = "완료"
        }
    }
    
    enum Action {
        case inputTextChanged(String) // 텍스트 필드
        case addButtonTapped // 추가 버튼 탭
        case todoToggled(id: UUID) // 완료 체크 초글
        case todoDeleted(id: UUID) // 삭제
        case filterChanged(State.Filter) // 필터 변경
    }
}
