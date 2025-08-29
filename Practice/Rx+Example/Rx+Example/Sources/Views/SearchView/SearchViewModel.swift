//
//  SearchViewModel.swift
//  Rx+Example
//
//  Created by 서준일 on 8/29/25.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel: BaseViewModel {
    
    var disposeBag = DisposeBag()
    
    struct Input {
        let searchBarText: Observable<String>
        let searchButtonTapped: Observable<Void>
    }
    
    struct Output {
        let searchResult: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        
        let searchResult = input.searchButtonTapped
            .withLatestFrom(input.searchBarText)
            .map { text in
                // 네트워킹
                
                return text
            }
            .asDriver(onErrorJustReturn: "")
        
        return Output(searchResult: searchResult)
    }
}
