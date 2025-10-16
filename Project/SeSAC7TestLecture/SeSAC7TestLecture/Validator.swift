//
//  Validator.swift
//  SeSAC7TestLecture
//
//  Created by 서준일 on 10/16/25.
//

import Foundation

struct User {
    let email: String
    let password: String
    let check: String
}

struct Validator {
    func isValidID(email: String) -> Bool {
        return email.contains("@") && email.count >= 6
    }
    
    func isValidPassword(password: String) -> Bool {
        return password.count >= 6 && password.count < 10
    }
}
