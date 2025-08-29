//
//  CustomObservable.swift
//  Rx+Example
//
//  Created by 서준일 on 8/29/25.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

final class CustomObservable {
    
    static func searchProduct(query: String, sort: SortType = .date, displayCount: Int = 30, start: Int) -> Observable<Result<ShoppingResponse, APIError>>  {
        
        return Observable.create { observer in
            
            NetworkManager.shared.fetchData(query: query, sort: sort, displayCount: displayCount, start: start) { response in
                switch response {
                case .success(let shoppingResponse):
                    observer.onNext(.success(shoppingResponse))
                case .failure(let error):
                    observer.onNext(.failure(error))
                }
                
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
}
