//
//  ValidateProtocol.swift
//  MVVMBasic
//
//  Created by 서준일 on 8/8/25.
//

import Foundation

protocol ValidateProtocol {
    
    func validateUserData<T: LosslessStringConvertible & Comparable>(_ text: String?, min: T, max: T) -> Result<T, InputError>
}

extension ValidateProtocol {
    func validateUserData<T: LosslessStringConvertible & Comparable>(_ text: String?, min: T, max: T) -> Result<T, InputError> {
        guard let text = text, !text.isEmpty else { return .failure(.empty) }
        guard !text.contains(" ") else { return .failure(.containsWhitespace) }
        guard let number = T(text) else { return .failure(.notNumeric) }
        guard number >= min && number <= max else { return .failure(.outOfRange(min: min, max: max)) }
        
        return .success(number)
    }
}
