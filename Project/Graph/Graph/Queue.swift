//
//  Queue.swift
//  Graph
//
//  Created by Bran on 12/2/25.
//

import Foundation

struct QueueWithArrayPointer<T> {
  private var elements: [T] = []
  private var front = 0

  var isEmpty: Bool {
    elements.count - front < 1
  }

  var count: Int {
    elements.count - front
  }

  mutating func push(with element: T) {
    elements.append(element)
  }

  @discardableResult
  mutating func pop() -> T? {
    if isEmpty {
      return nil
    } else {
      defer { front += 1 }
      return elements[front]
    }
  }

  func top() -> T? {
    isEmpty ? nil : elements[front]
  }
}

extension QueueWithArrayPointer: CustomStringConvertible {
  var description: String {
    (front..<elements.count).map { elements[$0] }.description
  }
}
