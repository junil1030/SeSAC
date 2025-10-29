//
//  Network.swift
//  SeSAC7SwiftUIBasic
//
//  Created by 서준일 on 10/29/25.
//

import Foundation

struct Network {
    
    private init() { }
    
    static func fetchAllMarket() async throws -> Markets {
          let url = URL(string: "https://api.upbit.com/v1/market/all")!
          
          let (data, response) = try await URLSession.shared.data(from: url)
          
          guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
              throw APIError.invalidResponse
          }
          
          let decodedData = try JSONDecoder().decode(Markets.self, from: data)
          return decodedData
      }
}

enum APIError: Error {
    case invalidResponse
}

struct Market: Hashable, Codable, Identifiable {
    let id = UUID()
    let market, koreanName, englishName: String
    var like = false

    enum CodingKeys: String, CodingKey {
        case market
        case koreanName = "korean_name"
        case englishName = "english_name"
    }
}

typealias Markets = [Market]
