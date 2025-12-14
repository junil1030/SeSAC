//
//  TreeNode.swift
//  Tree
//
//  Created by Bran on 12/8/25.
//

import Foundation

final class TreeNode<T: Equatable> {
  var value: T
  var children: [TreeNode] = []

  init(value: T) {
    self.value = value
  }

  func add(_ child: TreeNode) {
    children.append(child)
  }
}

// MARK: - Traverse
extension TreeNode {
  /// 구현의 편의를 위해서 Tree의 Value는 중복되지 않는다고 가정
  func bfs_vis() where T: Hashable {
    var queue: [TreeNode] = []
    var front = 0

    var vis: [T: Void] = [:] // 방문 여부를 확인하기 위한 변수

    queue.append(self)
    vis[self.value] = ()

    while queue.count >= front + 1 {
      // 1) 큐에서 노드를 빼고(출력),
      let curNode = queue[front]
      front += 1
      print(curNode.value)
      // 해당 노드와 연결되어 있는 노드들을 돌면서,
      for child in curNode.children {
        // 이미 방문한 노드면, skip
        if let _ = vis[child.value] { continue }
        // 처음 방문하는 노드라면, 방문했다는 표시를 남기고, 큐에 넣어준다.
        vis[child.value] = ()
        queue.append(child)
      }
    }
  }

  func dfs_vis() where T: Hashable {
    var stack: [TreeNode] = []
    var vis: [T: Void] = [:]

    stack.append(self)
    vis[self.value] = ()

    while !stack.isEmpty {
      let curNode = stack.removeLast()
      print(curNode.value)

      for child in curNode.children {
        if let _ = vis[child.value] { continue }
        vis[child.value] = ()
        stack.append(child)
      }
    }
  }

  func bfs() {
    var queue: [TreeNode] = []
    var front = 0

    queue.append(self)

    while queue.count >= front + 1 {
      let curNode = queue[front]
      front += 1

      print(curNode.value)

      queue.append(contentsOf: curNode.children)
    }
  }
}
