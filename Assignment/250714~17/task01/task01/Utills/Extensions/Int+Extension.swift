//
//  Int+Extension.swift
//  task01
//
//  Created by 서준일 on 7/18/25.
//

import Foundation

extension Int {
    var formattedWithComma: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
