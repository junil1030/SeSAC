//
//  LottoViewModel.swift
//  Tamagotchi
//
//  Created by 서준일 on 8/26/25.
//

import Foundation
import RxSwift
import RxCocoa

final class LottoViewModel {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let searchButtonClicked: Observable<String>
    }
    
    struct Output {
        let lottoResult: Driver<Result<Lotto, APIError>>
    }
    
    func transform(input: Input) -> Output {
        
        let lottoResult = input.searchButtonClicked
            .distinctUntilChanged()
            .flatMap { text in
                CustomObservable.getLottoResult(query: text)
            }
            .asDriver(onErrorJustReturn: .failure(.unknownError))
        
        return Output(lottoResult: lottoResult)
    }
}
