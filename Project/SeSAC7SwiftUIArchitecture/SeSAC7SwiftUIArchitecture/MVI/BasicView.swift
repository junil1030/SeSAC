//
//  BasicView.swift
//  SeSAC7SwiftUIArchitecture
//
//  Created by 서준일 on 11/12/25.
//

import SwiftUI
import Combine

struct BasicState {
    var count = 0
}

enum BasicIntent {
    case incrementButtonTapped
}

final class BasicStore: ObservableObject {
    @Published private(set) var state = BasicState()
    
    func action(_ intent: BasicIntent) {
        switch intent {
        case .incrementButtonTapped:
            state.count += 1
        }
    }
}

struct BasicView: View {
    @StateObject private var store = BasicStore()
    
    var body: some View {
        VStack {
            Text("Count: \(store.state.count)")
            BasicChildFirstView()
        }
        .environmentObject(store)
    }
}

struct BasicChildFirstView: View {
    
    var body: some View {
        VStack {
            Text("BasicChildFirstView")
            BasicChildSecondView()
        }
    }
}

struct BasicChildSecondView: View {
    
    var body: some View {
        VStack {
            Text("BasicChildSecondView")
            BasicLastView()
        }
    }
}

struct BasicLastView: View {
    
    @EnvironmentObject var store: BasicStore
    // 필요할 때 환경에서 직접 꺼내서 사용!
    
    var body: some View {
        Button("버튼 클릭") {
            store.action(.incrementButtonTapped)
        }
    }
}

#Preview {
    BasicView()
}
