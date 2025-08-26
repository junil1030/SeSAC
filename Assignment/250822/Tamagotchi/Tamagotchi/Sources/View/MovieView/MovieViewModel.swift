//
//  MovieViewModel.swift
//  Tamagotchi
//
//  Created by 서준일 on 8/26/25.
//

import Foundation
import RxSwift
import RxCocoa

final class MovieViewModel {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let searchButtonClicked: Observable<String>
    }
    
    struct Output {
        let movieList: Driver<[Movie]>
        let errorMessage: Driver<String?>
    }
    
    func transform(input: Input) -> Output {
        
        let result = input.searchButtonClicked
            .distinctUntilChanged()
            .flatMap { text in
                CustomObservable.getDailyBoxOfficeResult(date: text)
            }
            .asDriver(onErrorJustReturn: .failure(.unknownError))
        
        let movieList = result
            .map { result -> [Movie] in
                if case .success(let movies) = result {
                    return movies
                }
                return []
            }
        
        let errorMessgae = result
            .map { result -> String? in
                if case .failure(let error) = result {
                    return error.localizedDescription
                }
                return nil
            }
        
        return Output(movieList: movieList, errorMessage: errorMessgae)
    }
}
