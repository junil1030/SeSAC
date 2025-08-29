//
//  Int+Extension.swift
//  Rx+Example
//
//  Created by 서준일 on 8/29/25.
//

import Foundation

extension Int {
    
    var formattedString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
    
    var wonString: String {
        return formattedString + "원"
    }
}
