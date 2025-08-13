//
//  ShoppingResponse.swift
//  task01
//
//  Created by 서준일 on 7/26/25.
//

import Foundation

// MARK: - 메인 응답 모델
struct ShoppingResponse: Decodable {
    let lastBuildDate: String
    let total: Int
    let start: Int
    let display: Int
    let items: [ShoppingItem]
}

// MARK: - 상품 아이템 모델
struct ShoppingItem: Decodable {
    let title: String
    let link: String
    let image: String
    let lprice: String
    let hprice: String
    let mallName: String
}
