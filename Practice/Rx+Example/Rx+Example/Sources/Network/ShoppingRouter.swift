//
//  ShoppingRouter.swift
//  Rx+Example
//
//  Created by 서준일 on 8/29/25.
//

import Foundation
import Alamofire

enum SortType: String {
    case sim
    case date
    case asc
    case dsc
    
    var displayName: String {
        switch self {
        case .sim:
            return "정확도"
        case .date:
            return "날짜순"
        case .asc:
            return "가격낮은순"
        case .dsc:
            return "가격높은순"
        }
    }
}

enum ShoppingRouter {
    case searchKeyword(keyword: String, sort: SortType, start: Int, displayCount: Int)
    
    private var baseURL: String {
        return "https://openapi.naver.com/v1/search/"
    }
    
    var endPoint: URL {
        switch self {
        case .searchKeyword:
            return URL(string: baseURL + "shop")!
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .searchKeyword:
            return [
                "X-Naver-Client-Id": APIKeys.id.rawValue,
                "X-Naver-Client-Secret": APIKeys.secret.rawValue
            ]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .searchKeyword:
            return .get
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .searchKeyword(let keyword, let sort, let start, let displayCount):
            return [
                "query": "\(keyword)",
                "display": "\(displayCount)",
                "start": "\(start)",
                "sort": "\(sort.rawValue)"
            ]
        }
    }
}
