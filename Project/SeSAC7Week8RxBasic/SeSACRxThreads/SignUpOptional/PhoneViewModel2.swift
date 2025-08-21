//
//  PhoneViewModel2.swift
//  SeSACRxThreads
//
//  Created by 서준일 on 8/21/25.
//

import Foundation
import RxSwift
import RxCocoa

class PhoneViewModel2 {
    
    struct Input {
        let buttonTap: ControlEvent<Void>
    }
    
    struct Output {
        let text: BehaviorSubject<String>
    }
    
    private let disposeBag = DisposeBag()
    
    init() {
        
    }
    
    func transform(input: Input) -> Output {
        
        let text = BehaviorSubject(value: "")
        
        input.buttonTap
            .bind(with: self) { owner, _ in
                text.onNext("칙촉 \(Int.random(in: 1...100))")
            }
            .disposed(by: disposeBag)
        
        return Output(text: text)
    }
}
