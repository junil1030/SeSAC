//
//  NetworkManager.swift
//  SeSAC7Week4Codebase
//
//  Created by 서준일 on 7/29/25.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func callRequest(completionHandeler: @escaping ([Coin]) -> Void) {
        let url = "https://api.upbit.com/v1/market/all"
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [Coin].self) { response in
                switch response.result {
                case .success(let value):
                    completionHandeler(value)
                case .failure(let error):
                    print("fail", error)
                }
            }
    }

    func callRequestKakao(query: String, page: Int = 1, success: @escaping (KakaoBookInfo) -> Void, fail: @escaping () -> Void) {
        let url = "https://dapi.kakao.com/v3/search/book?query=\(query)&size=20&page=\(page)"
        let header: HTTPHeaders = [
            "Authorization": APIConfig.kakao
        ]
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: KakaoBookInfo.self) { response in
                switch response.result {
                case .success(let value):
                    success(value)
                case .failure(let error):
                    print("fail", error)
                }
            }
    }
}
