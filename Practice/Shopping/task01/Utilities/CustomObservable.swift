//
//  CustomObservable.swift
//  task01
//
//  Created by 서준일 on 8/31/25.
//

import Foundation
import RxSwift
import RxCocoa

final class CustomObservable {
    
    static func fetchItems(with keyword: String, sort: SortType, start: Int) -> Observable<Result<ShoppingResponse, Error>> {
        
        return Observable<Result<ShoppingResponse, Error>>.create { observer in
            
            APIService.shared.searchProduct(keyword: keyword, sort: sort, start: start) { response in
                switch response {
                case .success(let value):
                    observer.onNext(.success(value))
                case .error(let errorCode, let error):
                    observer.onNext(.failure(error))
                }
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
}
