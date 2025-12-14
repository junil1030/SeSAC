//
//  main.swift
//  BinaryTree
//
//  Created by Bran on 12/9/25.
//

import Foundation

// MARK: - Binary Tree
var binaryTree = BinaryTreeArray(rootValue: 7)
binaryTree.insert(1, at: 2)
binaryTree.insert(2, at: 3)
binaryTree.insert(77, at: 4)
binaryTree.insert(1, at: 5)
binaryTree.insert(1, at: 6)
binaryTree.insert(3, at: 7)

print("-----")
print("PreOrder 전위순회")
binaryTree.preorder()
print("-----")
print("InOrder 중위순회")
binaryTree.inorder()
print("-----")
print("PostOrder 후위순회")
binaryTree.postorder()
print("-----")

// MARK: - Heap
var heap = MinHeap<Int>()
heap.insert(with: 10)
heap.insert(with: 15)
heap.insert(with: 67)
heap.insert(with: 3)

print(heap.delete())
print(heap.delete())
print(heap.delete())
print(heap.delete())
