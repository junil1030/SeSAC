//
//  NetworkManager.swift
//  task01
//
//  Created by 서준일 on 7/28/25.
//

import Foundation
import Alamofire

protocol NetworkMonitoring {
    func startNetworkMonitoring()
    func stopNetworkMonitoring()
}

protocol NetworkStatusProvider {
    var currentStatus: NetworkStatus { get }
    var isConnected: Bool { get }
}

protocol NetworkManagerProtocol: NetworkMonitoring, NetworkStatusProvider {}

enum NetworkStatus {
    case wifi
    case cellular
    case disconnected
    case unknown
    
    var isConnected: Bool {
        switch self {
        case .wifi, .cellular:
            return true
        case .disconnected, .unknown:
            return false
        }
    }
    
    var description: String {
        switch self {
        case .wifi:
            return "WiFi 연결됨"
        case .cellular:
            return "셀룰러 연결됨"
        case .disconnected:
            return "인터넷 연결 안됨"
        case .unknown:
            return "연결 상태 알 수 없음"
        }
    }
}

class NetworkManager: NetworkManagerProtocol {
    
    static let shared = NetworkManager()
    private init() {}
    
    private let reachabilityManager = NetworkReachabilityManager()
    
    var currentStatus: NetworkStatus {
        guard let reachability = reachabilityManager else { return .unknown }
        
        switch reachability.status {
        case .notReachable:
            return .disconnected
        case .reachable(.ethernetOrWiFi):
            return .wifi
        case .reachable(.cellular):
            return .cellular
        case .unknown:
            return .unknown
        }
    }
    
    var isConnected: Bool {
        return currentStatus.isConnected
    }
    
    func startNetworkMonitoring() {
        reachabilityManager?.startListening { [weak self] status in
            let _ = self?.currentStatus
        }
    }
    
    func stopNetworkMonitoring() {
        reachabilityManager?.stopListening()
    }
}
