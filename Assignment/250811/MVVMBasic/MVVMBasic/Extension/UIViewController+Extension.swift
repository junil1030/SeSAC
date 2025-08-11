//
//  UIViewController+Extension.swift
//  MVVMBasic
//
//  Created by 서준일 on 8/7/25.
//

import UIKit

enum InputError: Error {
    case empty
    case containsWhitespace
    case notNumeric
    case outOfRange(min: Any, max: Any)
    case unknown
    
    var message: String {
        switch self {
        case .empty:
            return "입력된 숫자가 없어요."
        case .containsWhitespace:
            return "공백없이 입력해주세요."
        case .notNumeric:
            return "숫자만 입력해주세요."
        case .outOfRange(let min, let max):
            return "\(min) 부터 \(max) 사이의 숫자만 입력해주세요."
        case .unknown:
            return "알 수 없는 오류가 발생했어요."
        }
    }
}

extension UIViewController {
    
    func showToast(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            alert.dismiss(animated: true)
        }
    }
    
    // func validateUserData<T>(_ text: String?, min: T, max: T) throws -> T where T: LosslessStringConvertible & Comparable {
    // 이렇게 뒤에 where를 붙여서 사용할 수도 있음
    func validateUserData<T: LosslessStringConvertible & Comparable>(_ text: String?, min: T, max: T) throws -> T {
        guard let text = text, !text.isEmpty else { throw InputError.empty }
        guard !text.contains(" ") else { throw InputError.containsWhitespace }
        guard let number = T(text) else { throw InputError.notNumeric }
        guard number >= min && number <= max else { throw InputError.outOfRange(min: min, max: max) }
        
        return number
    }
}
