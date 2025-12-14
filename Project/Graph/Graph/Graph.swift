//
//  Graph.swift
//  Graph
//
//  Created by Bran on 12/2/25.
//

import Foundation

// MARK: - Graph Expression

/// Directed [x] + Weighted [x] + AdjMatrix
/// - Parameters:
///   - node: node의 개수
///   - edges: [from, to] 2차원 배열로 표현된 각 노드간 연결 구성 정보

func graphAdjMat(_ node: Int, _ edges: [[Int]]) {
    var adjMat: [[Int]] = .init(repeating: .init(repeating: 0, count: node + 1), count: node + 1)
    
    for node in edges {
        let from = node[0]
        let to = node[1]
        
        adjMat[from][to] = 1
        adjMat[to][from] = 1
    }
    
    for y in 1...node {
        for x in 1...node {
            print(adjMat[y][x], terminator: " ")
        }
        print("")
    }
}



/// Directed [o] + Weighted [x] + AdjMatrix
/// - Parameters:
/// - node: node의 개수
/// - edges: [ [1, 2], [2, 3] ] 2차원 배열로 표현된 각 노드간 연결 구성 정보
func directedGraphAdjMat(_ node: Int, _ edges: [[Int]]) {
    var adjMat: [[Int]] = .init(repeating: .init(repeating: 0, count: node + 1), count: node + 1)
    
    for edge in edges {
        let from = edge[0]
        let to = edge[1]
        
        adjMat[from][to] = 1
    }
    
    for y in 1...node {
        for x in 1...node {
            print(adjMat[y][x], terminator: " ")
        }
        print("")
    }
}


func weightedGraphAdjMat(_ node: Int, _ cost: [[Int]]) {
    var adjMat: [[Int]] = .init(repeating: .init(repeating: 0, count: node + 1), count: node + 1)
    
    
    for edge in cost {
        let from = edge[0]
        let to = edge[1]
        
        adjMat[from][to] = edge[2]
    }
    
    for y in 1...node {
        for x in 1...node {
            let formattedString = String(format: "%2d", adjMat[y][x])
            print(formattedString, terminator: " ")
        }
        print("")
    }
}

/// Directed [x] + Weighted [x] + AdjList

func graphAdjList(_ node: Int, _ edges: [[Int]]) {
    var adjList: [[Int]] = .init(repeating: [], count: node + 1)
    
    for edge in edges {
        let from = edge[0]
        let to = edge[1]
        
        adjList[from].append(to)
        adjList[to].append(from)
    }
    
    for i in 1...node {
        print(adjList[i])
    }
}



// MARK: - Graph Search

/// - Complexity: O(?)
/// - Parameters:
///   - node: node의 개수
///   - edges: [from, to] 형태의 2차원 배열
func bfsAdjMatrix(_ node: Int, _ edges: [[Int]]) {
    var adjMat: [[Int]] = .init(repeating: .init(repeating: 0, count: node + 1), count: node + 1)
    
    for node in edges {
        let from = node[0]
        let to = node[1]
        
        adjMat[from][to] = 1
        adjMat[to][from] = 1
    }
    
    // 3) 큐가 Empty가 될 때까지 1, 2번 과정 반복
    var vis: [Bool] = .init(repeating: false, count: node + 1)
    var queue: [Int] = []
    var front = 0

    // 1) 시작하는 노드를 Queue에 넣고 방문했다는 표시를 남김
    queue.append(1)
    vis[1] = true
    
    while queue.count >= front + 1 {
        // 2) 큐에서 노드를 꺼내고
        let cur = queue[front]
        front += 1
        print(cur)
        
        // 해당 노드와 연결된 노드에 대해 이미 방문한 노드인 경우 아무것도 하지 않고, 처음으로 방문하는 거라면 방문했다는 표시를 남기고 큐에 넣음
        for degree in 1...node {
            if adjMat[cur][degree] == 0 { continue }
            // 큐에서 뽑아준 노드와 연결되어 있는 노드인 경우
            if vis[degree] { continue }
            vis[degree] = true
            queue.append(degree)
        }
    }
}


/// - Complexity: O(?)
/// - Parameters:
///   - node: node의 개수
///   - edges: [from, to] 형태의 2차원 배열
func bfsAdjList(_ node: Int, _ edges: [[Int]]) {
    var adjList = Array(repeating: [Int](), count: node + 1)
    
    for edge in edges {
        let from = edge[0]
        let to = edge[1]
        
        adjList[from].append(to)
        adjList[to].append(from)
    }
    
    var queue = QueueWithArrayPointer<Int>()
    let front = 1
    var visited = Array(repeating: false, count: node + 1)
    
    queue.push(with: front)
    visited[front] = true
    
    while !queue.isEmpty {
        let cur = queue.pop()
        guard let cur = cur else { continue }
        print(cur)
        
        for degree in adjList[cur] {
            if visited[degree] { continue }
            visited[degree] = true
            queue.push(with: degree)
        }
    }
}

//let board1: [[Int]] = [
//  [1, 2], [2, 3], [3, 4],
//  [2, 6], [6, 4], [4, 5]
//]


func dfsAdjList(_ node: Int, _ edges: [[Int]]) {
    var adjList = Array(repeating: [Int](), count: node + 1)
    
    for edge in edges {
        let from = edge[0]
        let to = edge[1]
        
        adjList[from].append(to)
        adjList[to].append(from)
    }
    
    var vis: [Bool] = .init(repeating: false, count: node + 1)
    var stack: [Int] = []
    
    stack.append(1)
    vis[1] = true
    
    while stack.count > 0 {
        let cur = stack.removeLast()
        print(cur)
        
        for degree in adjList[cur] {
            if vis[degree] { continue }
            vis[degree] = true
            stack.append(degree)
        }
    }
    
    var visited = Array(repeating: false, count: node + 1)
    let start = 1
    dfs(start)
    
    func dfs(_ cur: Int) {
        visited[cur] = true
        print(cur)
        
        for degree in adjList[cur] {
            if visited[degree] { continue }
            visited[degree] = true
            dfs(degree)
        }
    }
}
