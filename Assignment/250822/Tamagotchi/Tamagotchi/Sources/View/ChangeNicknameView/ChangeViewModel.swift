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
        let changeFail: Driver<Void>
    }
    
    func transfer(input: Input) -> Output {
        
        let title = dataManager.loadUserNickname()
        let navigationTitle = "\(title ?? "대장")님 이름 정하기"
        let titleDriver = Driver.just(navigationTitle)
        
        let nicknameText = input.saveButtonTapped
            .compactMap { $0 }
            .share()
        
        let changeComplete = nicknameText
            .filter { $0.count >= 2 && $0.count <= 6 }
            .withUnretained(self) { owner, nickname in
                owner.dataManager.saveUserNickname(nickname)
            }
            .asDriver(onErrorJustReturn: ())
        
        let changeFail = nicknameText
            .filter { $0.count < 2 && $0.count > 6 }
            .map { _ in () }
            .asDriver(onErrorJustReturn: ())
        
        return Output(
            title: titleDriver,
            changeComplete: changeComplete,
            changeFail: changeFail
        )
    }
}
