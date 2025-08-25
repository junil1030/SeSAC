//
//  CustomObservable.swift
//  Tamagotchi
//
//  Created by 서준일 on 8/25/25.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

final class CustomObservable {
    
    static func getLotto(query: String) -> Observable<Lotto> {
        
        return Observable<Lotto>.create { observer in
            
            let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(query)"
            
            AF.request(url).responseDecodable(of: Lotto.self) { response in
                switch response.result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                    
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    static func getDailyBoxOffice(date: String) -> Observable<[Movie]> {
        
        return Observable.create { observer in
            
            let url = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIKey.kobis.rawValue)&targetDt=\(date)"
            
            AF.request(url).responseDecodable(of: BoxOfficeResponse.self) { response in
                switch response.result {
                case .success(let value):
                    observer.onNext(value.boxOfficeResult.dailyBoxOfficeList)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}
