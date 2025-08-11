//
//  Observable.swift
//  MVVMBasic
//
//  Created by 서준일 on 8/11/25.
//

import Foundation

class Observable<T> {
    
    private var observer: ((T) -> Void)?
    
    var value: T {
        didSet {
            observer?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ observer: @escaping (T) -> Void) {
        observer(value)
        self.observer = observer
    }
}
