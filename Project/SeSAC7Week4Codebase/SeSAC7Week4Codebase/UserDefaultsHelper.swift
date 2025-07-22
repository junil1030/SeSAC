//
//  UserDefaultsHelper.swift
//  SeSAC7Week4Codebase
//
//  Created by 서준일 on 7/22/25.
//

import Foundation

struct UserDefaultsHelper {
    
    var name: String {
        get {
            UserDefaults.standard.string(forKey: "name") ?? "손님"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "name")
        }
    }
    
    var age: Int {
        get {
            UserDefaults.standard.integer(forKey: "age")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "age")
        }
    }
}
