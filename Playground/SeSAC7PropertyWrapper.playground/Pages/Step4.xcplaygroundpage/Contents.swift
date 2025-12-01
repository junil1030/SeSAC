//: [Previous](@previous)

import Foundation

@propertyWrapper
struct JunDefaults<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
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
    
    @JunDefaults(key: Key.email.rawValue, defaultValue: "이메일 없음")
    static var email
    
    @JunDefaults(key: Key.nickname.rawValue, defaultValue: "닉네임 없음 ")
    static var nickname
    
    @JunDefaults(key: Key.phone.rawValue, defaultValue: 0)
    static var phone
}

/*
 A 목표
 - A가 없을 땐 어떻게 했을까?
 - 뭐가 불편해서 뭐가 아쉬워서 A가 등장했을까?
 - 진짜로 어떤 걸 해결을 해주고 있는지?
 - 실제로 A를 어떻게 활용하고 있느지?
 - 왜?
 */

//: [Next](@next)
