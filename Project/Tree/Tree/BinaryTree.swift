//
//  BinaryTree.swift
//  Tree
//
//  Created by Bran on 12/8/25.
//

import Foundation

// MARK: - Node기반 BinaryTree
final class BinaryTree<T: Equatable> {
    var value: T
    var leftChild: TreeNode<T>?
    var rightChild: TreeNode<T>?
    
    init(_ value: T) {
        self.value = value
    }
}

// MARK: - 순회
///  학습했던 BFS / DFS 코드를 작성해보세요!
extension BinaryTree {
    func bfs() {
        
    }
    
    func dfs() {
        
    }
}

// MARK: - Array기반 BinaryTree
struct BinaryTreeArray<T: Equatable> {
    private var elements: [T?] = [nil]
    
    init(rootValue: T) {
        self.elements.append(rootValue)
    }
    
    private mutating func expandIfNeeded(index: Int) {
        while elements.count <= index {
            elements.append(nil)
        }
    }
    
    mutating func insert(_ value: T, at index: Int) {
        expandIfNeeded(index: index)
        elements[index] = value
    }
}

// MARK: - 순회
extension BinaryTreeArray {
    func preorder(_ index: Int = 1) {
        guard index < elements.count,
              let node = elements[index]
        else { return }
        
        print(node)
        preorder(index * 2)
        preorder(index * 2 + 1)
    }
    
    func inorder(_ index: Int = 1) {
        guard index < elements.count,
              let node = elements[index]
        else { return }
        
        inorder(index * 2)
        print(node)
        inorder(index * 2 + 1)
    }
    
    func postorder(_ index: Int = 1) {
        guard index < elements.count,
              let node = elements[index]
        else { return }
        
        postorder(index * 2 + 1)
        postorder(index * 2)
        print(node)
    }
}

//     7
//  1     2
//77 1   1 3
