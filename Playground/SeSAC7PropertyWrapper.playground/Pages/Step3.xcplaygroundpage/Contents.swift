//: [Previous](@previous)

import Foundation

struct User {
    let name: String
    let age: String
    
    var introduce: String {
        get {
            return "제 이름은 \(self.name), 나이는 \(self.age)입니다."
        }
    }
}

struct JunDefaults<T> {
    let key: String
    let defaultValue: T
    
    var myValue: T {
        get {
            (UserDefaults.standard.object(forKey: key) as? T ?? defaultValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

enum UserDefaultsManager {
    
    enum Key: String {
        case email
        case nickname
        case phone
    }
    
    static var email = JunDefaults(key: Key.email.rawValue, defaultValue: "이메일 없음")
    static var nickname = JunDefaults(key: Key.nickname.rawValue, defaultValue: "닉네임 없음")
    static var phone = JunDefaults(key: Key.phone.rawValue, defaultValue: 0)
}

//: [Next](@next)
