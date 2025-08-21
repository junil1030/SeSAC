//
//  NumberViewModel.swift
//  task01
//
//  Created by 서준일 on 8/21/25.
//

import Foundation
import RxSwift
import RxCocoa

final class NumberViewModel {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let number1: ControlProperty<String>
        let number2: ControlProperty<String>
        let number3: ControlProperty<String>
    }
    
    struct Output {
        let result: Observable<String>
    }
    
    init() {
        
    }
    
    func transfrom(input: Input) -> Output {
        let result = Observable.combineLatest(input.number1, input.number2, input.number3) { value1, value2, value3 in
            return (Int(value1) ?? 0) + (Int(value2) ?? 0) + (Int(value3) ?? 0)
        }
        .map { $0.description }
        
        return Output(result: result)
    }
}
