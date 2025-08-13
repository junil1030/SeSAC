//
//  PhotoRouter.swift
//  SeSAC7Week7
//
//  Created by 서준일 on 8/13/25.
//

import Foundation
import Alamofire

enum PhotoRouter {
    case one(id: Int)
    case list
    
    var baseURL: String {
        return "https://picsum.photos"
    }
    
    var endpoint: URL {
        switch self {
        case .one(let id):
            return URL(string: baseURL + "/id/\(id)/info")!
        case .list:
            return URL(string: baseURL + "/v2/list?page=1&limit=20")!
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var param: Parameters {
        switch self {
        case .one(let id):
            return [:]
        case .list:
            return ["page": 1, "limit": 20]
        }
    }
}
