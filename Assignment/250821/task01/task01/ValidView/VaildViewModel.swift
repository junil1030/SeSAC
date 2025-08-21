//
//  VaildViewModel.swift
//  task01
//
//  Created by 서준일 on 8/21/25.
//

import Foundation
import RxSwift
import RxCocoa

final class ValidViewModel {
    
    private let disposeBag = DisposeBag()
    private let minimumUsernameTextlength = 5
    private let minimumPasswordTextlength = 8
    
    struct Input {
        let userName: ControlProperty<String>
        let passWord: ControlProperty<String>
        let submitTap: ControlEvent<Void>
    }
    
    struct Output {
        let isUsernameValid: Observable<Bool>
        let isPasswordValid: Observable<Bool>
        let isPasswordFieldEnabled: Observable<Bool>
        let isSubmitButtonEnabled: Observable<Bool>
        let isShowAlert: Observable<Void>
    }
    
    init() { }
    
    func transform(input: Input) -> Output {
        let isUsernameValid = input.userName
            .withUnretained(self) { owner, text in
                return text.count >= owner.minimumUsernameTextlength
            }
            .distinctUntilChanged()
        
        let isPasswordValid = input.passWord
            .withUnretained(self) { owner, text in
                return text.count >= owner.minimumPasswordTextlength
            }
            .distinctUntilChanged()
        
        let isPasswordFieldEnabled = isUsernameValid
        
        let isSubmitButtonEnabled = Observable.combineLatest(isUsernameValid, isPasswordValid) { $0 && $1 }
        
        let isShowAlert = input.submitTap
            .withLatestFrom(isSubmitButtonEnabled)
            .filter { $0 == true }
            .map { _ in }
        
        return Output(
            isUsernameValid: isUsernameValid,
            isPasswordValid: isPasswordValid,
            isPasswordFieldEnabled: isPasswordFieldEnabled,
            isSubmitButtonEnabled: isSubmitButtonEnabled,
            isShowAlert: isShowAlert
        )
    }
}
