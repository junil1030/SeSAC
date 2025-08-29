//
//  ShoppingRouter.swift
//  task01
//
//  Created by 서준일 on 8/13/25.
//

import Foundation
import Alamofire

enum ShoppingRouter {
    case searchKeyword(keyword: String, sort: SortType, start: Int, display: Int)
    
    var baseURL: String {
        return "https://openapi.naver.com/v1/search/"
    }
    
    var endPoint: URL {
        switch self {
        case .searchKeyword:
            return URL(string: baseURL + "shop")!
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .searchKeyword:
            return  [
                "X-Naver-Client-Id": Bundle.main.object(forInfoDictionaryKey: "X-Naver-Client-Id") as! String,
                "X-Naver-Client-Secret": Bundle.main.object(forInfoDictionaryKey: "X-Naver-Client-Secret") as! String
            ]
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .searchKeyword(let keyword, let sort, let start, let display):
            return [
                "query": keyword,
                "display": display,
                "start": start,
                "sort": sort.rawValue
            ]
        }
    }
}
