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
    
    func searchProduct(keyword: String, sort: SortType = .sim, start: Int = 1, display: Int = 30, completion: @escaping (NetworkResult<ShoppingResponse>) -> Void) {
        let url = "https://openapi.naver.com/v1/search/shop"
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": Bundle.main.object(forInfoDictionaryKey: "X-Naver-Client-Id") as! String,
            "X-Naver-Client-Secret": Bundle.main.object(forInfoDictionaryKey: "X-Naver-Client-Secret") as! String
        ]
        
        let parameters: [String: Any] = [
            "query": keyword,
            "display": display,
            "start": start,
            "sort": sort.rawValue
        ]
        
        AF.request(url, parameters: parameters, headers: headers)
            .responseDecodable(of: ShoppingResponse.self) { response in
                let statusCode = response.response?.statusCode ?? 0
                
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.error(statusCode, error))
                }
            }
    }
    
//    func searchProductData(keyword: String, sort: SortType = .sim, start: Int = 1, display: Int = 30, completion: @escaping (Result<ShoppingResponse, Error>) -> Void) {
//        let url = "https://openapi.naver.com/v1/search/shop"
//        
//        let headers: HTTPHeaders = [
//            "X-Naver-Client-Id": Bundle.main.object(forInfoDictionaryKey: "X-Naver-Client-Id") as! String,
//            "X-Naver-Client-Secret": Bundle.main.object(forInfoDictionaryKey: "X-Naver-Client-Secret") as! String
//        ]
//        
//        let parameters: [String: Any] = [
//            "query": keyword,
//            "display": display,
//            "start": start,
//            "sort": sort.rawValue
//        ]
//        
//        AF.request(url, parameters: parameters, headers: headers)
//            .responseData { response in
//                let statusCode = response.response?.statusCode
//                
//                switch statusCode {
//                case 200:
//                    if let data = response.data {
//                        do {
//                            let data = try JSONDecoder().decode(ShoppingResponse.self, from: data)
//                            completion(.success(data))
//                        } catch {
//                            completion(.failure(error))
//                        }
//                    }
//                case .
//                }
//            }
//    }
}
