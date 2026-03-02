//
//  ContentView.swift
//  TCAStudy
//
//  Created by Youngmin Cho on 3/2/26.
//

import SwiftUI
import ComposableArchitecture

// 도메인 + 상태
struct CounterState: Equatable {
    var count = 0
}

// 도메인 + 액션
enum CounterAction: Equatable {
    case addCount // 카운트를 더하는 액션
    case subtractCount // 카운트를 빼는 액션
}

struct CounterEnvironment {
    
}

let counterReducer = Reduce<CounterState, CounterAction> { state, action in
      switch action {
      case .addCount:
          state.count += 1
          return .none
      case .subtractCount:
          state.count -= 1
          return .none
      }
  }

struct CounterView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    CounterView()
}
