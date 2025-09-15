//
//  Date+Extension.swift
//  task01
//
//  Created by 서준일 on 9/15/25.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}
