//
//  String+Extension.swift
//  SeSAC7Recap2
//
//  Created by 서준일 on 9/4/25.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(with: String) -> String {
        return String(format: self.localized, with)
    }
    
    func localized(with: String, age: Int) -> String {
        return String(format: self.localized, with, age)
    }
}
