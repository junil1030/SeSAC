//
//  Sort.swift
//  CT02
//
//  Created by Bran on 11/26/25.
//

import Foundation

/// https://www.acmicpc.net/problem/2751
func boj_2751() {
    let n = Int(readLine()!)!
    var numbers: [Int] = []
    for _ in 0..<n {
        let number = Int(readLine()!)!
        numbers.append(number)
    }
    
    var answer: String = ""
    for number in numbers.sorted() {
        answer.append("\(number)\n")
    }
    
    print(answer)
}

/// https://www.acmicpc.net/problem/11650
func boj_11650() {
    let num = Int(readLine()!)!
    var numbers: [(Int, Int)] = []
    
    for _ in 0..<num {
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        let left = input[0]
        let right = input[1]
        
        numbers.append((left, right))
    }
    
    numbers.sort { $0 < $1 }
    var answer: String = ""
    for number in numbers {
        answer.append("\(number.0) \(number.1)\n")
    }
    
    print(answer)
}

/// https://www.acmicpc.net/problem/10814
func boj_10814() {

}
