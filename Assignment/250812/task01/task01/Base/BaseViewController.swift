//
//  BaseViewController.swift
//  task01
//
//  Created by 서준일 on 7/25/25.
//

import UIKit

enum AlertType {
    case error
    case networkError
    case warning
    
    var title: String {
        switch self {
        case .error:
            return "오류"
        case .networkError:
            return "인터넷 연결 없음"
        case .warning:
            return "알림"
        }
    }
}

protocol ViewDesignProtocol: AnyObject {
    func configureHierarchy()
    func configureLayout()
    func configureView()
}

class BaseViewController: UIViewController, ViewDesignProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        configureLayout()
        configureView()
    }

    func configureHierarchy() {
        
    }
    
    func configureLayout() {
        
    }
    
    func configureView() {
        view.backgroundColor = .black
        navigationController?.navigationBar.tintColor = UIColor.white
        
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func showAlert(type: AlertType, message: String) {
        let alert = UIAlertController(title: type.title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
    
    func checkNetworkConnection() -> Bool {
        let status = NetworkManager.shared.currentStatus
        
        if !status.isConnected {
            showNetworkAlert(status: status)
            return false
        }
        return true
    }
    
    private func showNetworkAlert(status: NetworkStatus) {
        let message: String
        
        switch status {
        case .disconnected:
            message = "인터넷 연결을 확인하고 다시 시도해주세요."
        case .unknown:
            message = "네트워크 상태를 확인할 수 없습니다. 잠시 후 다시 시도해주세요."
        default:
            message = "인터넷 연결을 확인하고 다시 시도해주세요."
        }
        
        showAlert(type: .networkError, message: message)
    }
}
