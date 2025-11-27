//
//  HashTable.swift
//  CT02
//
//  Created by Bran on 11/26/25.
//

import Foundation

/// https://www.acmicpc.net/problem/7785
func boj_7785() {
    var ret: Dictionary<String, Bool> = [:]
    let n = Int(readLine()!)!
    
    for _ in 0..<n {
        let str = readLine()!.split(separator: " ")
        let name = String(str[0])
        let stat = String(str[1])
        
        if stat == "enter" {
            ret[name] = true
        } else {
            ret[name] = false
        }
    }
    
    var result: [String] = []
    for element in ret {
        if element.value {
            result.append(element.key)
        }
    }
    result.sort(by: >)
    print(result.joined(separator: "\n"))
}


/// https://www.acmicpc.net/problem/1764
func boj_1764() {

}

func boj_3273() {
    let _ = Int(readLine()!)!
    let arr = readLine()!.split(separator: " ").map { Int($0)! }
    let x = Int(readLine()!)!
    
    var dic: [Int: Int] = [:]
    var answer = 0
    for element in arr {
        if element < x {
            if let _ = dic[x - element] {
                answer += 1
            } else {
                dic[element] = x - element
            }
        }
    }
}

func boj_3273_2() {
    let _ = Int(readLine()!)!
    let arr = readLine()!.split(separator: " ").map { Int($0)! }
    let x = Int(readLine()!)!

    var answer = 0
    var vis: [Bool] = Array(repeating: false, count: 2000000)
    
    for i in arr {
        if i < x &&  vis[x - i] { answer += 1 }
        vis[i] = true
    }
    
    print(answer)
}
