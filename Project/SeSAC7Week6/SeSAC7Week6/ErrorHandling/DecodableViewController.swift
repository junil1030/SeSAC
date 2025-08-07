//
//  DecodableViewController.swift
//  SeSAC7Week6
//
//  Created by 서준일 on 8/7/25.
//

import UIKit

struct Movie: Decodable {
    let movieTitle: String
    let likeCount: Int
    let director: String?
    let isTopRank: Bool

    enum CodingKeys: String, CodingKey {
        case movieTitle = "movie_title"
        case likeCount = "like_count"
        case director
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.movieTitle = try container.decode(String.self, forKey: .movieTitle)
        self.likeCount = try container.decode(Int.self, forKey: .likeCount)
        self.director = try container.decodeIfPresent(String.self, forKey: .director)
        self.isTopRank = (10000...).contains(likeCount) ? true : false
    }
}

/*
 1. 디코딩을 할 때, 키 값이 다르다면 디코딩 실패
 2. 1) 옵셔널로 해결하기 하지만 원하는 값을 담을 수 없음
 3.
    디코딩 전략 1. CodingKey를 활용하기
    디코딩 전략 2. snakecase. KeyDecodingStrategy / KeyEncodingStrategy
    디코딩 전략 3. init 으로 해결하기. decode / decodeIfPresent
 */

class DecodableViewController: UIViewController {

    let movie = """
        { 
          "movie_title": "좀비딸",
          "like_count": 12345,
          "director": null
        }
        """
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // String -> Data
        guard let data = movie.data(using: .utf8) else {
            print("실패")
            return
        }
        
        let decoder = JSONDecoder()
        
        // Data -> Struct
        do {
            let value = try decoder.decode(Movie.self, from: data)
            dump(value)
        } catch {
            print(error)
        }
        
        // response > decodable ->
    }
    
    
}
