//
//  KakaoBook.swift
//  SeSAC7Week4Codebase
//
//  Created by 서준일 on 7/28/25.
//

import Foundation

struct KakaoBookInfo: Decodable {
    let documents: [BookDetail]
    let meta: MetaInfo
}

struct BookDetail: Decodable {
    let price: Int
    let title: String
    let thumbnail: String
    let contents: String
    let url: String
}

struct MetaInfo: Decodable {
    let is_end: Bool
    let total_count: Int
    let pageable_count: Int
}
