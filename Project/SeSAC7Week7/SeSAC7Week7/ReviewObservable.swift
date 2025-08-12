//
//  ReviewObservable.swift
//  SeSAC7Week7
//
//  Created by 서준일 on 8/12/25.
//

import Foundation

class ReviewObservable<T> {
    
    private var action: (() -> Void)?
    
    var value: T {
        didSet {
            action?()
        }
    }
    
    init(_ value: T) {
        print("Observable Init: \(value)")
        self.value = value
    }
    
    func bind(_ closure: @escaping (() -> Void)) {
        print("Observable Bind")
        closure()
        self.action = closure
    }
    
    func lazyBind(_ closure: @escaping (() -> Void)) {
        print("Observable LazyBind")
        self.action = closure
    }
}
