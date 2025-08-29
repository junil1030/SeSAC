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
        let searchResult: Driver<Result<ShoppingResponse, APIError>>
    }
    
    func transform(input: Input) -> Output {
        
        let searchResult = input.searchButtonTapped
            .withLatestFrom(input.searchBarText)
            .flatMap { text in
                return CustomObservable.searchProduct(query: text, start: 1)
            }
            .asDriver(onErrorJustReturn: .failure(.unknownError))
        
        return Output(searchResult: searchResult)
    }
}
