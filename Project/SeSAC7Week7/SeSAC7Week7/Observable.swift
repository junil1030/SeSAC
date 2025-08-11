//
//  Observable.swift
//  SeSAC7Week7
//
//  Created by 서준일 on 8/11/25.
//

import Foundation

class Observable {
    
    var hello: (() -> Void)?
    
    // 처음에 들어오는 값은 didSet이 실행되지 않음을 알 수 있다 ..
    var text: String {
        didSet {
            print("change Text.. \(oldValue) -> ", text)
            hello?()
        }
    }
    
    init(text: String) {
        self.text = text
        print("init \(text), make Observable instance")
    }
    
    func bind(closure: @escaping () -> Void) {
        closure()
        self.hello = closure
    }
}

class Field<T> {
    
    private var action: ((T) -> Void)?
    
    var value: T {
        didSet {
            print("change Text.. \(oldValue) -> ", value)
            action?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
        print("init \(value), make Observable instance")
    }
    
    func playAction(action: @escaping (T) -> Void) {
        print(#function, "START")
        action(value)
        self.action = action
        print(#function, "END")
    }
}
