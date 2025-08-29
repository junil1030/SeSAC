//
//  APIService.swift
//  task01
//
//  Created by 서준일 on 7/26/25.
//

import Foundation
import Alamofire

enum NetworkResult<T> {
    case success(T)
    case error(Int, Error)
}

class APIService {
    static let shared = APIService()
    
    private init() {}
    
    private func callRequest<T: Decodable>(api: ShoppingRouter, completionHandler: @escaping (NetworkResult<T>) -> Void) {
        AF.request(api.endPoint,
                   method: api.method,
                   parameters: api.parameters,
                   headers: api.headers)
        .responseDecodable(of: T.self) { response in
            let statusCode = response.response?.statusCode ?? 0
            
            switch response.result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.error(statusCode, error))
            }
        }
    }
    
    func searchProduct(keyword: String, sort: SortType = .sim, start: Int = 1, display: Int = 30, completion: @escaping (NetworkResult<ShoppingResponse>) -> Void) {
        callRequest(api: .searchKeyword(keyword: keyword, sort: sort, start: start, display: display), completionHandler: completion)
    }
}
