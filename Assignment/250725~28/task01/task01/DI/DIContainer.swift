//
//  DIContainer.swift
//  task01
//
//  Created by 서준일 on 7/30/25.
//

import Foundation

protocol DIprotocol {
    func resolve<T>(_ type: T.Type) -> T
}

class DIContainer: DIprotocol {
    private let networkManager: NetworkManagerProtocol
    
    init() {
        self.networkManager = NetworkManager()
    }
    
    func resolve<T>(_ type: T.Type) -> T {
        switch type {
        case is NetworkManagerProtocol.Type:
            return networkManager as! T
        default:
            fatalError("Cannot Resolve \(type)")
        }
    }
}

class DIContainerManager {
    static let shared = DIContainer()
    
    private init() {}
}
