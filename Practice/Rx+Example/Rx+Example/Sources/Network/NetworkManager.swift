//
//  NetworkManager.swift
//  Rx+Example
//
//  Created by 서준일 on 8/29/25.
//

import Foundation
import Alamofire

enum APIError: Error {
    case networkError(AFError)
    case unknownError
    
    var description: String {
        switch self {
        case .networkError(let afError):
            return afError.localizedDescription
        case .unknownError:
            return "알 수 없는 오류입니다."
        }
    }
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    private func callRequest<T: Decodable>(api: ShoppingRouter, completionHandler: @escaping (Result<T, APIError>) -> Void) {
        AF.request(api.endPoint,
                   method: api.method,
                   parameters: api.parameters,
                   headers: api.headers
        ).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(.success(value))
            case .failure(let error):
                switch error {
                case .sessionTaskFailed, .requestRetryFailed:
                    completionHandler(.failure(.networkError(error)))
                default:
                    completionHandler(.failure(.unknownError))
                }
            }
        }
    }
    
    func fetchData(query: String, sort: SortType, displayCount: Int = 30, start: Int, completionHandler: @escaping (Result<ShoppingResponse, APIError>) -> Void) {
        callRequest(api: .searchKeyword(keyword: query, sort: sort, start: start, displayCount: displayCount), completionHandler: completionHandler)
    }
}
