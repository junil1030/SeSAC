//
//  PhoneViewModel.swift
//  SeSACRxThreads
//
//  Created by 서준일 on 8/21/25.
//

import Foundation
import RxSwift
import RxCocoa

class PhoneViewModel {
    
    struct Input {
        let buttonTap: ControlEvent<Void>
        let text: ControlProperty<String>
    }
    
    struct Output {
        let text: BehaviorSubject<String>
    }
    
    private let disposeBag = DisposeBag()
    
    init() { }
    
    func transform(input: Input) -> Output {
        let labelText = BehaviorSubject(value: "")
        
        input.buttonTap
            .withLatestFrom(input.text)
            .map { text in
                text.count >= 8 ? "통과" : "8자 이상 입력해주세요"
            }
            .bind(with: self) { owner, value in
                labelText.onNext(value)
            }
            .disposed(by: disposeBag)
        
        
        return Output(text: labelText)
    }
}
