//
//  QueueWithCircularArray.swift
//  03_Stack_Queue
//
//  Created by Bran on 10/28/25.
//

import Foundation

struct QueueWithCirculrArray<T> {
  private var elements: [T?]
  private var front = 0 // 제일 먼저온 인덱스
  private var rear = 0 // 제일 마지막에 들어온 인덱스 + 1
  private let size: Int

  init(size: Int) {
    self.size = size
    self.elements = .init(repeating: nil, count: size)
  }

  private var count: Int {
    rear - front
  }

  private var isEmpty: Bool {
    count == 0
  }

  private var isFull: Bool {
    (size - count) == 0
  }

  mutating func push(with element: T) {
    if !isFull {
      elements[rear % size] = element
      rear += 1
    }
  }

  @discardableResult
  mutating func pop() -> T? {
    if !isEmpty {
      let element = elements[front % size]
      defer { front += 1 }
      return element
    } else {
      return nil
    }
  }
}
