//
//  main.swift
//  01_Complexity
//
//  Created by Bran on 3/24/25.
//

import Foundation

/// 1부터 n 까지의 합을 반환하는 메서드를 완성해주세요!
/// - Parameter n: 1이상의 양의 정수
/// - Returns: 1부터 n 까지의 합
func sum(_ n: Int) -> Int {
    return (n + 1) * n / 2
}

func sum_1(_ n: Int) -> Int {
    var result = 0
    for i in 1...n {
        result += i
    }
    
    return result
}

func sum_2(_ n: Int) -> Int {
    return (0...n).reduce(0, +)
}

/// - 예시1:  [1, 10, 3, 9, 9] = 10 * 9 = 90
/// - 예시2:  [1, 10, 3, 9, 10] = 10 * 10 = 100
/// - Parameter numbers: 중복이 허용되는 길이 2 이상의 [Int] 배열
/// - Returns: numbers에서 가장 큰 값 * numbers에서 두번째로 큰 값
func findMaxValue(numbers: [Int]) -> Int {
    // 정렬은 nlogn의 시간 복잡도를 갖음
//    let ary = numbers.sorted(by: { $0 > $1 })
//    return ary[0] * ary[1]
    
    // 방법 1
    // 1) numbers에서 최대값을 찾고, 인덱스 찾은다음 인덱스 삭제
    // 2) 이거를 두 번 실행시켜서 최대값 두개 곱
    
    // 방법 2
    var first = Int.min
    var second = Int.min
    
    for number in numbers {
        if number >= first {
            second = first
            first = number
        } else if number >= second {
            second = number
        }
    }
    
    return first * second
}


/// 1) 4로 나누어 떨어지는 해는 윤년
/// 2) 4와 100으로 나누어 떨어지는 해는 평년
/// 3) 4, 100, 400으로 나누어 떨어지는 해는 윤년
/// - Parameter year: year
/// - Returns: 윤년인 경우 true, 윤년이 아닌 경우 false반환
func isLeapYear(year: Int) -> Bool {
    if year % 4 == 0 {
        if year % 100 == 0 {
            if year % 400 == 0 {
                return true
            } else {
                return false
            }
        } else {
            return true
        }
    } else {
        return false
    }
}


func complexity(arr: [Int]) -> Int {
  0
}

print(findMaxValue(numbers: [1, 10, 3, 9, 9]))
print(findMaxValue(numbers: [1, 10, 3, 9, 10]))
