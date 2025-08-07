//
//  UIViewController+Extension.swift
//  MVVMBasic
//
//  Created by 서준일 on 8/7/25.
//

import UIKit

extension UIViewController {
    
    func showToast(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            alert.dismiss(animated: true)
        }
    }
    
    
}
