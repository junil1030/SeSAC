//
//  main.swift
//  03_Stack_Queue
//
//  Created by Bran on 10/28/25.
//

import Foundation

func 메인함수() {
  let main = 10
  함수A()
  print("function Main Complete")
}

func 함수A() {
  let a = 20
  함수B()
  print("function A Complete")
}

func 함수B() {
  let b = 30
  print("function B Complete")
}

//메인함수()

var q = QueueWithArrayPointer<Int>()

print(q.description)
q.pop()
print(q.description)
q.push(with: 5)
print(q.top())
q.push(with: 10)
print(q.description)
q.pop()
print(q.description)
q.pop()
q.pop()
q.pop()
print(q.pop())
