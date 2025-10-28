//
//  Stack.swift
//  03_Stack_Queue
//
//  Created by Bran on 10/28/25.
//

import Foundation

struct Stack<T> {
    private var elements: [T] = []
}

extension Stack {
    /// Stack에 데이터 추가
    /// - Complexity: O(1)
    mutating func push(with element: T) {
        elements.append(element)
    }
    
    /// Stack에서 데이터 제거
    /// - Complexity: O(1)
    /// - Returns: 가장 최근에 들어온 데이터
    @discardableResult
    mutating func pop() -> T? {
        return elements.popLast()
    }
    
    
    /// Stack의 최상단 데이터
    func top() -> T? {
        elements.last
    }
}

extension Stack: CustomStringConvertible {
    var description: String {
        elements.description
    }
}
