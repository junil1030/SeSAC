//
//  CountView.swift
//  SeSAC7SwiftUIArchitecture
//
//  Created by 서준일 on 11/3/25.
//

import SwiftUI
import Combine

struct CountView: View {
    
    @State private var nicknameField = ""
    
    var body: some View {
        VStack {
            TextField("닉네임을 입력해보세요", text: $nicknameField)
            ChildCountView()
        }
    }
}

// StateObject(하위 뷰의 값 유지) vs Observableobject(하위 뷰 초기화)
// State > body > 인스턴스가 새롭게 생성됨
// @StateObject로 선언된 인스턴스는 생성 시점에 한 번 초기화 되고, 이후 뷰의 렌더링 여부와 상관없이 @Stateobject로 선언된 변수는 뷰 내에서 재사용 됩니다.
// iOS 17+ @Observable

struct ChildCountView: View {
    
    @StateObject private var viewModel = ChildCountViewModel()
    @Bindable private var viewModelObservable = ChildCountViewModelObservable()
    
    var body: some View {
        HStack {
            Text("숫자: \(viewModel.count)")
            Button("클릭") {
                viewModel.incrementCount()
            }
            
            Text("옵저버블: \(viewModelObservable.count)")
            Button("클릭") {
                viewModelObservable.incrementCount()
            }
            
            Text("이너 클래스 숫자: \(viewModel.inner.value)")
            Button("클릭") {
                viewModel.inner.increment()
            }
        }
    }
}

@Observable
class ChildCountViewModelObservable {
    var count = 0
    
    func incrementCount() {
        count += 1
    }
}

class ChildCountViewModel: ObservableObject {
    
    @Published var inner = InnerViewModel()
    @Published var count = 10
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        inner.objectWillChange
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }
    
    func incrementCount() {
        count += 1
    }
}

class InnerViewModel: ObservableObject {
    @Published var value = 0
    
    func increment() {
        value += 1
    }
}

#Preview {
    CountView()
}
