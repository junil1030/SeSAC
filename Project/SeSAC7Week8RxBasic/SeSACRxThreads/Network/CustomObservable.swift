//
//  CustomObservable.swift
//  SeSACRxThreads
//
//  Created by 서준일 on 8/25/25.
//

import Foundation
import Alamofire
import RxSwift

struct Lotto: Decodable {
    let drwNoDate: String
    let firstAccumamnt: Int
}

final class CustomObservable {
    
    static func getLottoWithSingle(query: String) -> Single<Result<Lotto, junError>> {
        
        return Single.create { observer in
            
            let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(query)"
            
            AF.request(url).responseDecodable(of: Lotto.self) { response in
                switch response.result {
                case .success(let value):
                    print(value)
                    observer(.success(.success(value)))
                case .failure(let error):
                    print(error)
                    observer(.success(.failure(.invalid)))
                }
            }
            
            return Disposables.create()
        }
    }
    
    static func textCompletionHandler(query: String, handler: @escaping (Result<Lotto, Error>) -> Void) {
        
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(query)"
        
        AF.request(url).responseDecodable(of: Lotto.self) { response in
            switch response.result {
            case .success(let value):
                print(value)
                handler(.success(value))
            case .failure(let error):
                print(error)
                handler(.failure(error))
            }
        }
    }
    
    static func getLotto(query: String) -> Observable<Result<Lotto, junError>> {
        
        return Observable<Result<Lotto, junError>>.create { observer in
            
            let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(query)"
            
            AF.request(url).responseDecodable(of: Lotto.self) { response in
                switch response.result {
                case .success(let value):
                    print(value)
                    observer.onNext(.success(value))
                    observer.onCompleted()
                    
                case .failure(let error):
                    print(error)
                    observer.onNext(.failure(junError.invalid))
                    observer.onCompleted()

                }
            }
            
            return Disposables.create()
        }
    }
    
    static func randomNumber() -> Observable<Int> {
        
        return Observable<Int>.create { observer in
            
            observer.onNext(Int.random(in: 1...100))
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    static func recommendNickname() -> Observable<String> {
        
        return Observable<String>.create { observer in
            let text: [String?] = ["고래밥", nil, "칙촉", nil, "카스타드", "몽쉘", "오예스"]
            
            guard let random = text.randomElement(), let result = random else {
                observer.onError(junError.invalid)
                return Disposables.create()
            }
            
            if result == "카스타드" {
                observer.onError(junError.invalid)
            } else {
                observer.onNext(result)
            }
            
            return Disposables.create()
        }
    }
}
