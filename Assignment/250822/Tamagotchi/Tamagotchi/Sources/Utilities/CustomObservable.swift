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

enum APIError: Error {
    case networkError(AFError)
    case decodingError(DecodingError)
    case unknownError
    
    var localizedDescription: String {
        switch self {
        case .networkError(let afError):
            return afError.localizedDescription
        case .decodingError(let decodingError):
            return decodingError.localizedDescription
        case .unknownError:
            return "알 수 없는 오류 발생"
        }
    }
}

final class CustomObservable {
    
    static func getLottoResult(query: String) -> Observable<Result<Lotto, APIError>> {
        
        return Observable<Result<Lotto, APIError>>.create { observer in
            let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(query)"
            
            AF.request(url).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let lotto = try JSONDecoder().decode(Lotto.self, from: data)
                        observer.onNext(.success(lotto))
                    } catch let decodingError as DecodingError {
                        observer.onNext(.failure(.decodingError(decodingError)))
                    } catch {
                        observer.onNext(.failure(.unknownError))
                    }
                case .failure(let error):
                    switch error {
                    case .sessionTaskFailed, .requestRetryFailed:
                        observer.onNext(.failure(.networkError(error)))
                    default:
                        observer.onNext(.failure(.unknownError))
                    }
                }
                
                observer.onCompleted()
            }
            return Disposables.create()
        }
        
    }
    
    static func getDailyBoxOfficeResult(date: String) -> Single<Result<[Movie], APIError>> {
        
        return Single.create { observer in
            
            let url = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIKey.kobis.rawValue)&targetDt=\(date)"

            AF.request(url).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let movies = try JSONDecoder().decode(BoxOfficeResponse.self, from: data)
                        observer(.success(.success(movies.boxOfficeResult.dailyBoxOfficeList)))
                    } catch let decodingError as DecodingError {
                        observer(.success(.failure(.decodingError(decodingError))))
                    } catch {
                        observer(.success(.failure(.unknownError)))
                    }
                case .failure(let error):
                    switch error {
                    case .sessionTaskFailed, .requestRetryFailed:
                        observer(.success(.failure(.networkError(error))))
                    default:
                        observer(.success(.failure(.unknownError)))
                    }
                }
            }
            
            return Disposables.create()
        }
    }
    
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
