                                                                    //
//  PhotoError.swift
//  SeSACRxThreads
//
//  Created by 서준일 on 8/18/25.
//

import Foundation

enum NetworkError: Int, Error {
    case badRequest     = 400
    case unauthorized   = 401
    case forbidden      = 403
    case notFound       = 404
    case serverError    = 500
    case unknown        = 503
    
    var userResponse: String {
        switch self {
        case .badRequest:
            return "Bad Request입니다."
        case .unauthorized:
            return "Unauthorized입니다."
        case .forbidden:
            return "Forbidden입니다."
        case .notFound:
            return "NotFound입니다."
        case .serverError:
            return "ServerError입니다."
        case .unknown:
            return "unknown입니다."
        }
    }
}
