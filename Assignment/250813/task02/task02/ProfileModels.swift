//
//  ProfileModels.swift
//  task02
//
//  Created by 서준일 on 8/13/25.
//

import Foundation

enum NicknameStatus {
    case empty
    case valid
    case tooShort
    case tooLong
    case containsSpecialChar
    case containsNumber
}

struct MBTI {
    var firstType: String?
    var secondType: String?
    var thirdType: String?
    var fourthType: String?
    
    mutating func toggle(_ type: String) {
        switch type {
        case "E", "I":
            firstType = (firstType == type) ? nil : type
        case "S", "N":
            secondType = (secondType == type) ? nil : type
        case "T", "F":
            thirdType = (thirdType == type) ? nil : type
        case "J", "P":
            fourthType = (fourthType == type) ? nil : type
        default:
            break
        }
    }
    
    func contains(_ type: String) -> Bool {
        return firstType == type || secondType == type || thirdType == type || fourthType == type
    }
    
    func isComplete() -> Bool {
        return firstType != nil && secondType != nil && thirdType != nil && fourthType != nil
    }
    
    func getMBTIString() -> String {
        guard isComplete(),
              let first = firstType,
              let second = secondType,
              let third = thirdType,
              let fourth = fourthType else {
            return ""
        }
        return "\(first)\(second)\(third)\(fourth)"
    }
}
