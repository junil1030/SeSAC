//
//  2667.swift
//  Graph
//
//  Created by 서준일 on 12/4/25.
//

import Foundation

func q2667() {
    let n = Int(readLine()!)!
    var graph: [[Int]] = []
    
    for _ in 0..<n {
        let line = readLine()!.map { Int(String($0))! }
        graph.append(line)
    }
    
    let dy = [-1, 0 ,1, 0]
    let dx = [0, -1, 0, 1]
    var visited: [[Bool]] = Array(repeating: .init(repeating: false, count: n), count: n)
    var answer: [Int] = []
    
    var queue = QueueWithArrayPointer<(Int, Int)>()
    
    for y in 0..<n {
        for x in 0..<n {
            if graph[y][x] == 0 || visited[y][x] { continue }
            
            let start = (y, x)
            visited[y][x] = true
            queue.push(with: start)
            var count =  0
            
            while !queue.isEmpty {
                let (cy, cx) = queue.pop()!
                count += 1
                
                for i in 0..<4 {
                    let ny = cy + dy[i]
                    let nx = cx + dx[i]
                    
                    if ny < 0 || nx < 0 || ny >= n || nx >= n { continue }
                    if graph[ny][nx] == 0 { continue }
                    if visited[ny][nx] { continue }
                    
                    queue.push(with: (ny, nx))
                    visited[ny][nx] = true
                }
            }
            
            answer.append(count)
        }
    }
    
    print(answer.count)
    for i in answer.sorted() {
        print(i)
    }
}
