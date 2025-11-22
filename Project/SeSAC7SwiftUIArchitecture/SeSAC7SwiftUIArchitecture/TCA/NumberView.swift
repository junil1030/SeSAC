//
//  NumberView.swift
//  SeSAC7SwiftUIArchitecture
//
//  Created by 서준일 on 11/18/25.
//

import SwiftUI
import Combine
import ComposableArchitecture

// State, Intent, Store
// Reducer Protocol > State, Action, Body
// Reducer Protocol -> @Reducer 매크로
@Reducer
struct NumberFeature: Reducer {
    
    // Equatable 지금은 없어도 상관 없음 !
    @ObservableState // State 구조체를 SwiftUI가 관찰하고, 뷰가 업데이트 되도록함
    struct State {
        var number = 0
    }
    
    enum Action {
        case increment
        case decrement
    }

    // state, action -> Effect
    // 동기 > 사이드이펙트 x > 일관된 결과
    // 비동기 > 사이드이펙트 o > X
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .increment:
                state.number += 1
                return .none
            case .decrement:
                state.number -= 1
                return .none
            }
        }
    }
}

//struct NumberState {
//    var number = 0
//}
//
//enum NumberIntent {
//    case increment
//    case decrement
//}
//
//final class NumberStore: ObservableObject {
//    
//    @Published private(set) var state = NumberState()
//    
//    func action(_ intent: NumberIntent) {
//        switch intent {
//        case .increment: state.number += 1
//        case .decrement: state.number -= 1
//        }
//    }
//}

struct NumberView: View {
    
    let store: StoreOf<NumberFeature>
    
    var body: some View {
        VStack {
            Text("number: \(store.number)")
            HStack {
                Button("-") {
                    store.send(.decrement)
                }
                
                Button("+") {
                    store.send(.increment)
                }
            }
        }
    }
}

#Preview {
    NumberView(store: Store(
        initialState: NumberFeature.State(),
        reducer: { NumberFeature() }
        )
    )
}
