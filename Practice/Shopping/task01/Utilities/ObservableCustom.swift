//
//  ObservableCustom.swift
//  task01
//
//  Created by 서준일 on 8/12/25.
//

import Foundation

class ObservableCustom<T> {
    
    private var action: ((T) -> Void)?
    
    var value: T {
        didSet {
            action?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(action: @escaping (T) -> Void) {
        action(value)
        self.action = action
    }
    
    func lazyBind(action: @escaping (T) -> Void) {
        self.action = action
    }
}
