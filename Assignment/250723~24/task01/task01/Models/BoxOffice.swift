//
//  BoxOffice.swift
//  task01
//
//  Created by 서준일 on 7/24/25.
//

import Foundation

// MARK: - Welcome
struct BoxOffice: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Decodable {
    let boxofficeType, showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

// MARK: - DailyBoxOfficeList
struct DailyBoxOfficeList: Decodable {
    let rank: String
    let movieNm: String
    let openDt: String
}
