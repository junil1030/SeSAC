//
//  List.swift
//  06_HashTable
//
//  Created by Bran on 10/29/25.
//

import Foundation

struct PhoneBookArray {
  var names = ["Hue", "Jack", "Bran", "Finn"]
  var numbers = ["01031258728", "01068927321", "01089210809", "01032094412"]

  /// - Complexity: O(N)
  /// - Parameter number: 입력값으로 들어온 전화번호
  /// - Returns: 해당 전화번호를 사용하는 사람의 이름
  func findNumber(_ number: String) -> String? {
    for i in 0..<numbers.count {
      if numbers[i] == number {
        return names[i]
      }
    }
    return nil
  }

  /// - Complexity: O(1)
  mutating func append(_ name: String, _ number: String) {
    names.append(name)
    numbers.append(number)
  }
}
