//
//  DummyData.swift
//  SeSAC7Week6
//
//  Created by 서준일 on 8/7/25.
//

import Foundation

struct DummyTrend {
    let id: Int
    let genreIds: [Int]
}

struct DummyImage {
    let path: String
    let id: Int
}

struct DummySearch {
    let path: String
    let des: String
}

struct DummyData<T, U> {
    let title: T
    let sub: U
}
