//
//  BoxOffice.swift
//  SeSAC7Week4Codebase
//
//  Created by 서준일 on 7/24/25.
//

import Foundation

struct BoxOffice: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Decodable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

struct DailyBoxOfficeList: Decodable {
    let rank: String
    let movieCd: String
    let movieNm: String
    let openDt: String
}
