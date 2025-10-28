//
//  Recursion.swift
//  03_Stack_Queue
//
//  Created by Bran on 10/28/25.
//

import Foundation

func 재귀함수() {
    print("재귀함수가 뭔가요?")
    return 재귀함수()
}

func fibo(_ n: Int) -> Int {
    if n == 0 { return 0 }
    else if n == 1 { return 1 }
    return fibo(n - 1) + fibo(n - 2)
}

func fiboDP(_ n: Int) -> Int {
    var cache: [Int] = [0, 1]
    for num in 2...n {
        cache.append(cache[num - 1] + cache[num - 2])
    }
    return cache[n]
}

/// 1부터 n까지의 합 구하기
func sum(_ n: Int) -> Int {
    if n == 1 { return 1 }
    return n + sum(n - 1)
}

/// - Parameters
///   - a: 정수
///   - b: 양의 정수
/// - Returns: a * b
func multiply(a: Int, b: Int) -> Int {
    1
}

/// - Parameter str: 길이 1이상의 문자열
/// - Returns: str을 뒤집은 값
func reverse(_ str: String) -> String {
    ""
}
