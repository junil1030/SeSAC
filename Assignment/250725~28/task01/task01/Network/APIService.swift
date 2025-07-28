//
//  APIService.swift
//  task01
//
//  Created by 서준일 on 7/26/25.
//

import Foundation
import Alamofire

class APIService {
    static let shared = APIService()
    
    private init() {}
    
    func searchProduct(keyword: String, sort: SortType = .sim, start: Int = 1, display: Int = 30, completion: @escaping (ShoppingResponse?) -> Void) {
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
                switch response.result {
                case .success(let data):
                    completion(data)
                case .failure:
                    completion(nil)
                }
            }
    }
}
