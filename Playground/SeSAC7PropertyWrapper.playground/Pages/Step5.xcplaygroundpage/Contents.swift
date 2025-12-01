//: [Previous](@previous)

import Foundation

@propertyWrapper
struct Currency {
    private var defaultValue: Int
    
    private(set) var projectedValue: Bool = true
    
    var wrappedValue: String {
        get {
            defaultValue.formatted(.number) + "원"
        }
        set {
            if let number = Int(newValue) {
                defaultValue = number
                projectedValue = true
            } else {
                projectedValue = false
            }
        }
    }
    
    init(wrappedValue: String) {
        if let amount = Int(wrappedValue) {
            self.defaultValue = amount
        } else {
            self.defaultValue = 0
        }
    }
}

struct Calculator {
    
    @Currency
    var korean: String
}

var cal = Calculator(korean: "12345")

cal.korean
cal.$korean

//: [Next](@next)
