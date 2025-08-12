//
//  UpbitManager.swift
//  SeSAC7Week7
//
//  Created by 서준일 on 8/12/25.
//

import Foundation
import Alamofire

final class UpbitManager {
    
    static let shared = UpbitManager()
    private init() {}
    
    func callRequest(completionHandler: @escaping ([Upbit], String) -> Void) {
        let url = "https://api.upbit.com/v1/market/all"
        
        AF.request(url).responseDecodable(of: [Upbit].self) { response in
            switch response.result {
            case .success(let value):
                let random = value.randomElement()?.korean_name ?? "없음"
                completionHandler(value, random)
            case .failure(let error):
                print(error)
            }
            
        }

    }
}
