//
//  ProfileViewModel.swift
//  SeSACRxThreads
//
//  Created by 서준일 on 8/27/25.
//

import Foundation
import RxSwift
import RxCocoa

final class ProfileViewModel: BaseViewModel {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let buttonTap: Observable<Void>
    }
    
    struct Output {
        let detail: Driver<String>
        let placeholder: Driver<String>
        let buttonTitle: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        
        let detail = PublishRelay<String>()
        
        input.buttonTap
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .default))
            .bind(with: self) { owner, _ in
                print("통신이 일어난다면", Thread.isMainThread)
                detail.accept("고래밥")
            }
            .disposed(by: disposeBag)
        
        return Output(detail: detail.asDriver(onErrorJustReturn: ""),
                      placeholder: Driver.just("닉네임 입력부탁"),
                      buttonTitle: Driver.just("버튼임"))
    }
}
