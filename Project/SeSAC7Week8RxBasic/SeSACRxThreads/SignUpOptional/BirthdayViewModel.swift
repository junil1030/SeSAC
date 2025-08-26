//
//  BirthdayViewModel.swift
//  SeSACRxThreads
//
//  Created by 서준일 on 8/22/25.
//

import Foundation
import RxSwift
import RxCocoa

class BirthdayViewModel: BaseViewModel {
    
    struct Input {
        //let datePicker: BehaviorSubject<Date>
    }
    
    let date: BehaviorSubject<Date> = BehaviorSubject(value: .now)
    
    struct Output {
        let year: BehaviorRelay<String>
        let month: BehaviorSubject<String>
        let day: Driver<String>
    }
    
    let disposeBag = DisposeBag()
    
    init() {}
    
    func transform(input: Input) -> Output {
        
        let year = BehaviorRelay(value: "2025")
        let month = BehaviorSubject(value: "8")
        let day = BehaviorSubject(value: "22")
        
        //input.datePicker
        date
            .bind(with: self) { owner, date in
                let component = Calendar.current.dateComponents([.year, .month, .day], from: date)
                
                year.accept("\(component.year!)")
                month.onNext("\(component.month!)")
                day.onNext("\(component.day!)")
            }
            .disposed(by: disposeBag)
        
        let result = day
            .asDriver(onErrorJustReturn: "OO일")
        
        return Output(
            year: year,
            month: month,
            day: result
        )
    }
}
