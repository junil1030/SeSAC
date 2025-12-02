//
//  main.swift
//  Graph
//
//  Created by Bran on 12/2/25.
//

import Foundation

/// without direction

//let board1: [[Int]] = [
//  [1, 2], [2, 3], [3, 4],
//  [2, 6], [6, 4], [4, 5]
//]
//print("widthout direction")
//graphAdjMat(board1.count, board1)
//print("\n----\n")

/// with direction

//let board2: [[Int]] = [
//  [1, 2], [3, 2], [2, 6],
//  [6, 4], [4, 3], [4, 5]
//]
//print("with direction")
//directedGraphAdjMat(board2.count, board2)
//print("\n----\n")


/// with weight, direction

// let costs: [[Int]] = [
//   [1, 2, 3], [3, 2, 1], [2, 6, 2],
//   [4, 3, 10], [6, 4, -3], [4, 5, 9]
// ]
//print("with weight, direction")
//weightedGraphAdjMat(costs.count, costs)
//print("\n----\n")


/// without direction

//let board1: [[Int]] = [
//  [1, 2], [2, 3], [3, 4],
//  [2, 6], [6, 4], [4, 5]
//]
//graphAdjList(board1.count, board1)



let board1: [[Int]] = [
  [1, 2], [2, 3], [3, 4],
  [2, 6], [6, 4], [4, 5]
]
bfsAdjMatrix(board1.count, board1)



/*
boardPrint(board: floodBoard)
floodFill()
boardPrint(board: floodBoard)
*/
