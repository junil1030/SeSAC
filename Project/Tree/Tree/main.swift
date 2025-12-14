//
//  main.swift
//  Tree
//
//  Created by Bran on 12/8/25.
//

import Foundation

// MARK: - Tree
let hue = TreeNode(value: "Hue")
let jack = TreeNode(value: "Jack")
let hoo = TreeNode(value: "Hoo")
let bran = TreeNode(value: "Bran")
let finn = TreeNode(value: "Finn")
let den = TreeNode(value: "Den")

hue.add(jack)
hue.add(bran)

jack.add(hoo)

bran.add(finn)
bran.add(den)

//hue.bfs()
//print("-------")
//hue.bfs_vis()
//print("-------")
//hue.dfs_vis()


// MARK: - Binary Tree
var binaryTree = BinaryTreeArray(rootValue: 7)
binaryTree.insert(1, at: 2)
binaryTree.insert(2, at: 3)
binaryTree.insert(77, at: 4)
binaryTree.insert(1, at: 5)
binaryTree.insert(1, at: 6)
binaryTree.insert(3, at: 7)

binaryTree.preorder()
print("-------")
binaryTree.inorder()
print("-------")
binaryTree.postorder()
