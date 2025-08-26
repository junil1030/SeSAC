//
//  BaseViewModelProtocol.swift
//  SeSACRxThreads
//
//  Created by 서준일 on 8/26/25.
//

import Foundation

// viewModel의 input, output 구조체 구조가 모두 다르니 제네릭을 도입해보자 ..?
// 프로토콜은 제네릭 <> 구조를 사용할 수 없긴함
// 그러면 어떻게 해야될까?
// -> associatedtype
protocol BaseViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
