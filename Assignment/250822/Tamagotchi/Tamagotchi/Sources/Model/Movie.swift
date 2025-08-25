//
//  Movie.swift
//  Tamagotchi
//
//  Created by 서준일 on 8/25/25.
//

struct BoxOfficeResponse: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Decodable {
    let dailyBoxOfficeList: [Movie]
}

struct Movie: Decodable {
    let rank: String
    let movieNm: String
}
