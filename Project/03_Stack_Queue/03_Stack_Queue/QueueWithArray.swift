//
//  QueueWithArray.swift
//  03_Stack_Queue
//
//  Created by Bran on 10/28/25.
//

import Foundation

struct QueueWithArray<T> {
    private var elements: [T] = []
    
    mutating func push(with element: T) {
//        elements.append(element)
        elements.insert(element, at: 0)
    }
    
    @discardableResult
    mutating func pop() -> T? {
//        if let first = elements.first {
//            elements.removeFirst()
//            return first
//        }
//        return nil
        
//        elements.isEmpty ? nil : elements.removeFirst()
        return elements.popLast()
    }
    
    func top() -> T? {
//        return elements.first
        return elements.last
    }
}

extension QueueWithArray: CustomStringConvertible {
    var description: String {
        elements.description
    }
}
