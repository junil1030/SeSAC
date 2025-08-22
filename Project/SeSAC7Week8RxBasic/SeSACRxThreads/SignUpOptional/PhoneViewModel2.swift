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
        let text: PublishSubject<String>
        let placeholder: PublishSubject<String>
        let nextText: PublishSubject<String>
    }
    
    private let disposeBag = DisposeBag()
    
    init() {
        
    }
    
    func transform(input: Input) -> Output {
        
        let text = PublishSubject<String>()
        input.buttonTap
            .bind(with: self) { owner, _ in
                text.onNext("칙촉 \(Int.random(in: 1...100))")
            }
            .disposed(by: disposeBag)
        
        let placeholder = PublishSubject<String>()
        let nextText = PublishSubject<String>()
        
        placeholder.onNext("연락처를 입력해주세요")
        nextText.onNext("다음")
        
        return Output(
            text: text,
            placeholder: placeholder,
            nextText: nextText
        )
    }
}
