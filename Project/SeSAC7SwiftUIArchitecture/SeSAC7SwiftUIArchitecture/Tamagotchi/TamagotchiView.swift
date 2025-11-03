//
//  TamagotchiView.swift
//  SeSAC7SwiftUIArchitecture
//
//  Created by 서준일 on 11/3/25.
//

/*
 RxSwift(클래스 기반) - Combine(Protocol 기반)
 RxCocoa - X
 
 Observable - Publisher
 Observer - Subscriber
 
 PublishSubject - PassThroughSubject
 BehaviorSubject - CurrentValueSubject
 
 .subscribe - .sink
 
 DisposeBag - AnyCancellable
 .disposed(by: ) - .store
 
 
 */

import SwiftUI

struct TamagotchiView: View {
    
    var viewModel = TamagotchiViewModelObservable()
    
    var body: some View {
        VStack {
            Text("밥알: \(viewModel.rice)개, 물방울 \(viewModel.water)개")
            HStack {
                //                TextField("밥알을 입력해주세요", text: $viewModel.riceField)
                Button("밥알") {
                    viewModel.addRice()
                }
            }
            HStack {
                //                TextField("물방울을 입력해주세요", text: $viewModel.waterField)
                Button("물방울") {
                    viewModel.addWater()
                }
            }
        }
    }
}

#Preview {
    TamagotchiView()
}
