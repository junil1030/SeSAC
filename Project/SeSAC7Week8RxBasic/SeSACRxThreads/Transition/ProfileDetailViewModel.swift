//
//  ProfileDetailViewModel.swift
//  SeSACRxThreads
//
//  Created by 서준일 on 8/27/25.
//

import Foundation
import RxSwift
import RxCocoa

final class ProfileDetailViewModel: BaseViewModel {
    
    private var text: String
    
    init(text: String) {
        self.text = text
    }
    
    struct Input { }
    
    struct Output {
        let navTitle: Observable<String>
    }
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
        let title = Observable.just("Junil \(Int.random(in: 1...100)) \(text)")
                                    
        return Output(navTitle: title)
    }
}
