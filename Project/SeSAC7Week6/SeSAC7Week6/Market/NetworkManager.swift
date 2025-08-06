//
//  NetworkManager.swift
//  SeSAC7Week6
//
//  Created by Jack on 8/6/25.
//

import Foundation
import Alamofire

// final을 붙이면 상속이 안된다. 메서드 재정의를 할 수 없음
// final을 붙이지 않으면, 컴파일 타임에 어떤 메서드가 실행될 지 명확하게 알기가 어렵다.
// final을 붙이면, 컴파일 타임에 어떤 메서드가 실행이 될지 명확하게 알 수 있다. 런타임 상황에서 할 것들이 상대적으로 줄어든다.

// final class, enum, struct => 컴파일 최적화

class Coffee {
    func make() {}
}

class Americano: Coffee {
    override func make() {
        super.make()
        
    }
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
     
    func callRequest(completionHandler: @escaping ([Coin]) -> Void) {
        let url = "https://api.upbit.com/v1/market/all"
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [Coin].self) { response in
                print(#function, "두번째")
                switch response.result {
                case .success(let value):
                    print("success", value)
                    completionHandler(value)
                case .failure(let error):
                    print("fail", error)
                }
            }
        print(#function, "세번째")
    }
    
}

