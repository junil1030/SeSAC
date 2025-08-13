//
//  Int++Extension.swift
//  task01
//
//  Created by 서준일 on 7/27/25.
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
