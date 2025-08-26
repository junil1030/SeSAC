//
//  ChangeViewModel.swift
//  Tamagotchi
//
//  Created by 서준일 on 8/25/25.
//

import RxSwift
import RxCocoa

final class ChangeViewModel {
    
    private let dataManager = DataManager.shared
    private let disposeBag = DisposeBag()
    
    struct Input {
        let saveButtonTapped: Observable<String?>
    }
    
    struct Output {
        let title: Driver<String>
        let changeComplete: Driver<Void>
        let showInputValidationAlert: Driver<ChangeNicknameViewController.InputNicknameValidationType>
    }
    
    func transfer(input: Input) -> Output {
        
        let title = dataManager.loadUserNickname()
        let navigationTitle = "\(title ?? "대장")님 이름 정하기"
        let titleDriver = Driver.just(navigationTitle)
        
        let showAlertRelay = PublishRelay<ChangeNicknameViewController.InputNicknameValidationType>()
        let changeCompleteRelay = PublishRelay<Void>()
        
        let nicknameText = input.saveButtonTapped
            .compactMap { $0 }
            .share()
        
        nicknameText
            .subscribe(with: self, onNext: { owner, nickname in
                if nickname.hasPrefix(" ") {
                    showAlertRelay.accept(.startsWithSpace)
                    return
                }
                
                let trimmedNickname = nickname.trimmingCharacters(in: .whitespacesAndNewlines)
                
                if trimmedNickname.count < 2 {
                    showAlertRelay.accept(.tooShort)
                    return
                }
                
                if nickname.count >= 6 {
                    showAlertRelay.accept(.tooLong)
                    return
                }
                
                owner.dataManager.saveUserNickname(nickname)
                changeCompleteRelay.accept(())
            })
            .disposed(by: disposeBag)
        
        let changeComplete = changeCompleteRelay
            .asDriver(onErrorJustReturn: ())
        
        let showInputValidationAlert = showAlertRelay
            .asDriver(onErrorJustReturn: .tooShort)
        
        return Output(
            title: titleDriver,
            changeComplete: changeComplete,
            showInputValidationAlert: showInputValidationAlert
        )
    }
}
