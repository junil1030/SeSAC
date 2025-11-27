//
//  2D-Array.swift
//  CT02
//
//  Created by Bran on 11/19/25.
//

import Foundation

/*
 Q1.
 * 입출력 예시 1
 [Input]
 4 5
 1 1 1 1 1 
 0 0 0 0 0
 1 0 1 0 1
 0 1 0 1 0

 [Output]
 0 1 0 1 0
 1 0 1 0 1
 0 0 0 0 0
 1 1 1 1 1

 * 입출력 예시 2
 [Input]
 3 2
 1 3
 0 4
 1 5

 [Output]
 1 5
 0 4
 1 3
 */
func q1() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }

    let r = input[0], c = input[1]

    var answer: [[Int]] = []

    for _ in 0..<input[0] {
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        answer.append(input)
    }

    answer.reverse()

    for y in 0..<r {
        for x in 0..<c {
            print(answer[y][x], terminator: " ")
        }
        print("")
    }
}


/*
 Q2.
 * 입출력 예시 1
 [Input]
 4 5
 1 1 1 1 1
 0 0 0 0 0
 1 0 1 0 1
 0 1 0 1 0

 [Output]
 1 0 1 0
 1 0 0 1
 1 0 1 0
 1 0 0 1
 1 0 1 0

 * 입출력 예시 2
 [Input]
 3 2
 1 3
 0 4
 1 5

 [Output]
 1 0 1
 3 4 5
 */
func q2_2() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let r = input[0], c = input[1]
    var answer: [[Int]] = .init(repeating: .init(repeating: 0, count: r), count: c)

    for y in 0..<r {
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        for x in 0..<c {
            answer[x][y] = input[x]
        }
    }

    for y in 0..<c {
        for x in 0..<r {
            print(answer[y][x], terminator: " ")
        }
        print("")
    }
}

/// https://www.acmicpc.net/problem/10798
func boj10798() {

}

