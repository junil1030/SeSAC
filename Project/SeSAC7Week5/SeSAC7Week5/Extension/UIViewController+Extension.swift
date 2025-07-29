//
//  UIViewController+Extension.swift
//  SeSAC7Week5
//
//  Created by 서준일 on 7/29/25.
//

import UIKit

extension UIViewController {
    // 탈출 클로저 @escaping
    func showAlert(title: String, message: String, ok: String, okHandler: @escaping () -> Void) {
        print("-----1-----")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: ok, style: .default) { _ in
            okHandler()
            print("-----3-----")
        }
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        self.present(alert, animated: true)
        print("-----2-----")
    }
}
